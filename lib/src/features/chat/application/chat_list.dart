import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meno_flutter/src/config/config.dart';
import 'package:meno_flutter/src/features/auth/auth.dart';
import 'package:meno_flutter/src/features/broadcast/broadcast.dart';
import 'package:meno_flutter/src/features/chat/chat.dart';
import 'package:meno_flutter/src/services/socket/socket.dart';
import 'package:meno_flutter/src/shared/shared.dart' show ID, MultiLineString;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'chat_list.g.dart';

@riverpod
Future<void> sendChatMessage(
  Ref ref, {
  required ID broadcastId,
  required MultiLineString content,
}) async {
  final chatListNotifier = ref.read(chatListProvider.notifier);
  final socket = ref.read(socketProvider.notifier);
  final user = ref.read(sessionProvider).value?.user;

  final contentString = content.getOrCrash();
  if (user == null || contentString.trim().isEmpty) {
    log('sendMessage aborted: User not logged in or content empty.');
    return;
  }

  const uuid = Uuid();

  // Generate Temporary ID and Object
  final tempId = ID.fromString(uuid.v4());
  final now = DateTime.now();
  final tempChat = _createChatObject(
    id: tempId,
    user: user,
    broadcastId: broadcastId,
    content: content,
    createdAt: now,
    status: ChatStatus.sending,
  );

  chatListNotifier.stageOptimisticMessage(
    optimisticChat: tempChat,
    rawContent: contentString,
    originalCreationTime: now,
  );

  try {
    final payload = {
      'senderId': user.id.getOrCrash(),
      'broadcastId': broadcastId,
      'content': content,
      'createdAt': now.toIso8601String(),
    };

    log('Sending message payload (no tempId): $payload');

    final ack = await socket.emitWithAck('sendChatMessage', payload);

    log('Received ack for sent message (tempId $tempId): $ack');

    final response = BaseResponse.fromJson(
      ack as Map<String, dynamic>,
      (json) => json as dynamic,
    );

    if (response.error != null) {
      log('Sending failed for tempId: $tempId. Error: ${response.error}');
      chatListNotifier.markMessageAsFailed(tempId);
    } else {
      // Success via Ack - message sent to server.
      // Now we wait for _onNewMessage or timeout.
      log('Sending successfull for tempId: $tempId.');
    }
  } on Exception catch (e) {
    log('Exception message or processing Ack for tempId $tempId: $e');
    chatListNotifier.markMessageAsFailed(tempId);
  }
}

@Riverpod(keepAlive: true)
class ChatList extends _$ChatList {
  Socket get _socket => ref.read(socketProvider.notifier);
  User? get _currentUser => ref.read(sessionProvider).value?.user;
  final Uuid _uuid = const Uuid();

  // Store temporary IDs -> Info map for messages currently being sent
  // Key: tempId
  final Map<ID, _PendingMessage> _pendingMessages = {};
  // Define timeout duration
  final Duration _messageTimeoutDuration = const Duration(seconds: 30);

  @override
  FutureOr<List<Chat?>> build() async {
    final id = ref.read(broadcastIDProvider);
    final user = _currentUser;
    if (id == null || user == null) {
      log('ChatList build: Missing broadcastId or user. Returning empty list.');
      return [];
    }

    state = const AsyncLoading();

    log('ChatList initializing for $id...');

    _setupSocketListeners();

    final facade = ref.read(chatFacadeProvider);
    final response = await facade.getChatMessages(broadcastId: id);

    final messages = response.fold(
      (exception) => throw exception,
      (paginatedList) => paginatedList.items,
    );

    final controller = StreamController<Chat>.broadcast();

    ref.onDispose(() {
      log('Disposing ChatList for $id...');
      _removeSocketListeners();
      controller.close();
    });

    return messages;
  }

  void _setupSocketListeners() {
    _socket.addListener('newMessage', _onNewMessage);
    _socket.addListener('editedMessage', _onEditedMessage);
    _socket.addListener('deletedMessage', _onDeletedMessage);
    log('Socket listeners added for chats list');
  }

  void _removeSocketListeners() {
    _socket.removeListener('newMessage', _onNewMessage);
    _socket.removeListener('editedMessage', _onEditedMessage);
    _socket.removeListener('deletedMessage', _onDeletedMessage);
    log('Socket listeners removed for chats list');
  }

  void _onNewMessage(dynamic data) {
    final currentUser = _currentUser;
    if (currentUser == null) return;

    state.whenData((currentMessages) {
      try {
        final json = _ensureMap(data);
        final dto = ChatDto.fromJson(json);
        final message = dto.toDomain.copyWith(status: ChatStatus.sent);
        final updatedMessages = List<Chat?>.from(currentMessages);
        var messageReplaced = false;

        // Check if it's from the current user
        if (message.senderId == currentUser.id) {
          log('Message from self (ID: ${message.id}), checking pending...');
          // Heuristic: Try to match based on content among pending messages
          ID? matchedTempId;
          _PendingMessage? matchedPendingMessage;

          // Iterate through pending messages to find a content match
          for (final entry in _pendingMessages.entries) {
            // Compare content carefully
            if (entry.value.content == message.content.getOrCrash()) {
              // Found a potential match! Use the first one found.
              matchedTempId = entry.key;
              matchedPendingMessage = entry.value;
              log('Content match found for tempId: $matchedTempId');
              break;
            }
          }

          if (matchedTempId != null && matchedPendingMessage != null) {
            // Found a match! Replace the temporary message.
            final index = updatedMessages.indexWhere(
              (c) => c?.id == matchedTempId,
            );

            if (index != -1) {
              log('Replace temp msg $matchedTempId: confirmed ${message.id}');
              log('Replace successful?: $messageReplaced');
              updatedMessages[index] = message;
              messageReplaced = true;
            } else {
              // Pending message existed, but wasn't found in the UI list?
              // Should not happen.
              log('Warning: Pending msg $matchedTempId not found in UI list.');
              log('Prepending confirmed message.');
              updatedMessages.insert(0, message);
            }

            // Cleanup pending tracking
            matchedPendingMessage.timer.cancel();
            _pendingMessages.remove(matchedTempId);
          } else {
            // Message from self, but no matching pending content found.
            // Could be from another client, or content mismatch. Add it.
            log('MSG:${message.id} from self not match any pending content.');
            log(' Prepending.');
            // Optional: Check for duplicate permanent ID before inserting
            final exists = updatedMessages.any((c) => c?.id == message.id);
            if (!exists) {
              updatedMessages.insert(0, message);
            } else {
              log('Duplicate msg:${message.id} from self, ignoring insertion.');
            }
          }
        } else {
          // Message from another user, just prepend
          log('Received message from other user: ${message.sender?.fullName}');
          // Optional: Check for duplicate permanent ID before inserting
          final exists = updatedMessages.any((chat) => chat?.id == message.id);
          if (!exists) {
            updatedMessages.insert(0, message);
          } else {
            log('Duplicate msg:${message.id} from others, ignore insertion');
          }
        }

        // Update state only if changes were made
        if (currentMessages.length != updatedMessages.length) {
          state = AsyncData(updatedMessages);
        }
      } on Exception catch (e) {
        log('Error processing newMessage: $e');
      }
    });

    // if (state.hasValue && state.value != null) {
    //   final json = _ensureMap(data);
    //   final message = ChatDto.fromJson(json).toDomain;
    //   final oldMessages = List<Chat?>.from(state.value ?? []);

    //   // Check if it's from the current user
    //   if (message.senderId == _currentUser?.id) {}

    //   state = AsyncData([message, ...oldMessages]);
    // }
  }

  void _onEditedMessage(dynamic data) {
    if (state.hasValue && state.value != null) {
      final json = _ensureMap(data);
      final message = ChatDto.fromJson(json).toDomain;
      final oldMessages = List<Chat?>.from(state.value ?? []);
      final updatedMessages =
          oldMessages.map((oldMessage) {
            if (oldMessage?.id == message.id) return message;
            return oldMessage;
          }).toList();
      state = AsyncData(updatedMessages);
    }
  }

  void _onDeletedMessage(dynamic data) {
    state.whenData((currentMessages) {
      try {
        final json = _ensureMap(data);
        final idToDeleteString = json['id'] as String?;
        if (idToDeleteString == null) {
          log('Error processing deletedMessage: Missing ID. Data: $data');
          return;
        }

        final idToDelete = ID.fromString(idToDeleteString);
        log('Removing deleted message: $idToDelete');

        // Also check if this ID corresponds to a pending message and clean up
        if (_pendingMessages.containsKey(idToDelete)) {
          _pendingMessages[idToDelete]?.timer.cancel();
          _pendingMessages.remove(idToDelete);
          log('Removed pending msg for $idToDelete as it was deleted.');
        }

        final initialLength = currentMessages.length;
        final updatedMessages =
            currentMessages.where((c) => c?.id != idToDelete).toList();

        if (updatedMessages.length < initialLength) {
          // Check if something was actually removed
          state = AsyncData(updatedMessages);
        }
      } on Exception catch (e) {
        log('Error processing deletedMessage: $e');
      }
    });
  }

  void stageOptimisticMessage({
    required Chat optimisticChat,
    required String rawContent,
    required DateTime originalCreationTime,
  }) {
    final tempId = optimisticChat.id;

    // Ensure no duplicate staging
    if (_pendingMessages.containsKey(tempId)) {
      log('ChatList: Optimistic message $tempId already staged.');
      return;
    }

    Timer? messageTimer;
    messageTimer = Timer(_messageTimeoutDuration, () {
      log('ChatList: Message timeout for tempId: $tempId');
      _handleMessageTimeout(tempId);
    });

    _pendingMessages[tempId] = _PendingMessage(
      content: rawContent,
      timer: messageTimer,
      createdAt: originalCreationTime,
    );

    state.whenData((currentMessages) {
      // Avoid adding if it somehow already got there (e.g., rapid events)
      if (!currentMessages.any((chat) => chat?.id == tempId)) {
        state = AsyncData([optimisticChat, ...currentMessages]);
        log('ChatList: Optimistically added message with tempId: $tempId');
      }
    });
  }

  void markMessageAsFailed(ID tempId) {
    if (_pendingMessages.containsKey(tempId)) {
      _pendingMessages[tempId]?.timer.cancel();
      _pendingMessages.remove(tempId);
      _updateMessageStatus(tempId, ChatStatus.failed);
      log('ChatList: Marked message as failed: $tempId');
    } else {
      // It might have been confirmed and removed from pending just before failure was processed
      log(
        'ChatList: Tried to mark $tempId as failed, but it was not in pending state (possibly already resolved).',
      );
      // Still update status if it's in the main list but not pending (edge case)
      _updateMessageStatus(tempId, ChatStatus.failed);
    }
  }

  // Future<void> sendMessage({
  //   required ID broadcastId,
  //   required MultiLineString content,
  // }) async {
  //   final user = _currentUser;
  //   final contentString = content.getOrCrash();
  //   if (user == null || contentString.trim().isEmpty) {
  //     log('sendMessage aborted: User not logged in or content empty.');
  //     return;
  //   }

  //   // 1. Generate Temporary ID and Object
  //   final tempId = ID.fromString(_uuid.v4());
  //   final now = DateTime.now();
  //   final tempChat = _createChatObject(
  //     id: tempId,
  //     user: user,
  //     broadcastId: broadcastId,
  //     content: content,
  //     createdAt: now,
  //     status: ChatStatus.sending,
  //   );

  //   // Setup timeout timer
  //   Timer? messageTimer; // Declare timer variable
  //   messageTimer = Timer(_messageTimeoutDuration, () {
  //     // Timer fired! Message likely timed out.
  //     log('Message timeout for tempId: $tempId');
  //     _handleMessageTimeout(tempId);
  //   });

  //   // Store pending info
  //   _pendingMessages[tempId] = _PendingMessage(
  //     content: contentString,
  //     timer: messageTimer,
  //     createdAt: now,
  //   );

  //   // 2. Optimistic UI Update
  //   state.whenData((currentMessages) {
  //     state = AsyncData([tempChat, ...currentMessages]);
  //     log('Optimistically added message with tempId: $tempId');
  //   });

  //   try {
  //     final payload = {
  //       'senderId': _currentUser?.id.getOrCrash(),
  //       'broadcastId': broadcastId,
  //       'content': content,
  //       'createdAt': now.toIso8601String(),
  //     };

  //     log('Sending message payload (no tempId): $payload');

  //     final ack = await _socket.emitWithAck('sendChatMessage', payload);

  //     log('Received ack for sent message (tempId $tempId): $ack');

  //     final response = BaseResponse.fromJson(
  //       ack as Map<String, dynamic>,
  //       (json) => json as dynamic,
  //     );

  //     if (response.error != null) {
  //       log('Sending failed for tempId: $tempId. Error: ${response.error}');
  //       _handleSendFailure(tempId);
  //     } else {
  //       // Success via Ack - message sent to server.
  //       // Now we wait for _onNewMessage or timeout.
  //       log('Sending successfull for tempId: $tempId.');
  //     }
  //   } on Exception catch (e) {
  //     log('Exception message or processing Ack for tempId $tempId: $e');
  //     _handleSendFailure(tempId);
  //   }
  // }

  Future<void> editMessage({
    required ID id,
    required ID senderId,
    required ID broadcastId,
    required MultiLineString content,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) async {}

  // Helper for timeout logic
  void _handleMessageTimeout(ID tempId) {
    // Check if it's still pending (wasn't confirmed/failed already)
    if (_pendingMessages.containsKey(tempId)) {
      log('Handling timeout failure for tempId: $tempId');
      _pendingMessages[tempId]?.timer.cancel();
      _pendingMessages.remove(tempId);
      _updateMessageStatus(tempId, ChatStatus.failed);
    } else {
      log('Timeout fired for $tempId, but it was already resolved.');
    }
  }

  // Helper for immediate send failure logic
  void _handleSendFailure(ID tempId) {
    if (_pendingMessages.containsKey(tempId)) {
      _pendingMessages[tempId]?.timer.cancel();
      _pendingMessages.remove(tempId);
      _updateMessageStatus(tempId, ChatStatus.failed);
    }
  }

  // Helper to update status (same as before)
  void _updateMessageStatus(ID messageId, ChatStatus status) {
    state.whenData((currentMessages) {
      var messageFound = false;
      final updatedMessages =
          currentMessages.map((chat) {
            if (chat?.id == messageId) {
              messageFound = true;
              return chat?.copyWith(status: status);
            }
            return chat;
          }).toList();

      if (messageFound) {
        // Only update if the list actually changed
        final hasChanges = currentMessages.length != updatedMessages.length;
        if (hasChanges) state = AsyncData(updatedMessages);
      } else {
        log('Message with ID: $messageId not found in the list.');
      }
    });
  }

  Map<String, dynamic> _ensureMap(dynamic data) {
    if (data is Map<String, dynamic>) return data;
    return jsonDecode(jsonEncode(data)) as Map<String, dynamic>;
  }
}

class _PendingMessage {
  final String content;
  final Timer timer;
  final DateTime createdAt;

  _PendingMessage({
    required this.content,
    required this.timer,
    required this.createdAt,
  });
}

Chat _createChatObject({
  required ID id,
  required User user,
  required ID broadcastId,
  required MultiLineString content,
  required DateTime createdAt,
  required ChatStatus status,
  DateTime? updatedAt,
}) {
  /* ... same implementation ... */
  return Chat(
    id: id,
    content: content,
    broadcastId: broadcastId,
    createdAt: createdAt,
    updatedAt: updatedAt,
    senderId: user.id,
    fullName: user.fullName,
    imageUrl: user.imageUrl,
    status: status,
    sender: ChatSender(
      id: user.id,
      fullName: user.fullName,
      imageUrl: user.imageUrl,
    ),
  );
}
