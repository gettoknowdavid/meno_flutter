import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:meno_flutter/src/config/config.dart';
import 'package:meno_flutter/src/features/auth/auth.dart';
import 'package:meno_flutter/src/features/broadcast/broadcast.dart';
import 'package:meno_flutter/src/features/chat/chat.dart';
import 'package:meno_flutter/src/services/socket/socket.dart';
import 'package:meno_flutter/src/shared/shared.dart' show ID, MultiLineString;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'chat_list.g.dart';

@Riverpod(keepAlive: true)
class ChatList extends _$ChatList {
  Socket get _socket => ref.read(socketProvider.notifier);
  AsyncValue<UserCredential?> get _session => ref.read(sessionProvider);
  ID? _tempID;

  @override
  FutureOr<List<Chat?>> build() async {
    final id = ref.read(broadcastIDProvider);
    if (id == null) return [];

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
    if (state.hasValue && state.value != null) {
      final json = _ensureMap(data);
      final message = ChatDto.fromJson(json).toDomain;
      final oldMessages = List<Chat?>.from(state.value ?? []);
      state = AsyncData([message, ...oldMessages]);
    }
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
    if (state.hasValue && state.value != null) {
      final json = _ensureMap(data);
      final message = ChatDto.fromJson(json).toDomain;
      final oldMessages = List<Chat?>.from(state.value ?? []);
      final updatedMessages =
          oldMessages.where((chat) => chat?.id != message.id).toList();
      state = AsyncData(updatedMessages);
    }
  }

  Future<void> sendMessage({
    required ID senderId,
    required ID broadcastId,
    required MultiLineString content,
    required DateTime createdAt,
  }) async {
    if (_session.value == null) return;
    _tempID = ID.fromString(const Uuid().v4());
    final tempChat = _getTemporaryChatObject(
      id: _tempID!,
      senderId: senderId,
      broadcastId: broadcastId,
      content: content,
      createdAt: createdAt,
      status: ChatStatus.sending,
    );

    final messages = List<Chat?>.from(state.value ?? []);
    state = AsyncData([tempChat, ...messages]);

    final event = await _socket.emitWithAck('sendChatMessage', {
      'senderId': senderId,
      'broadcastId': broadcastId,
      'content': content,
      'createdAt': createdAt,
    });

    final response = BaseResponse.fromJson(
      event as Map<String, dynamic>,
      (json) => json as dynamic,
    );

    if (response.error != null) {
      final oldMessages = List<Chat?>.from(state.value ?? []);
      final updatedMessages =
          oldMessages.map((chat) {
            if (chat?.id == tempChat.id) {
              return tempChat.copyWith(status: ChatStatus.failed);
            }
            return chat;
          }).toList();
      state = AsyncData(updatedMessages);
    }
  }

  Future<void> editMessage({
    required ID id,
    required ID senderId,
    required ID broadcastId,
    required MultiLineString content,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) async {
    if (_session.value == null) return;
  }

  Map<String, dynamic> _ensureMap(dynamic data) {
    if (data is Map<String, dynamic>) return data;
    return jsonDecode(jsonEncode(data)) as Map<String, dynamic>;
  }

  Chat _getTemporaryChatObject({
    required ID id,
    required ID senderId,
    required ID broadcastId,
    required MultiLineString content,
    required DateTime createdAt,
    required ChatStatus status,
    DateTime? updatedAt,
  }) {
    final user = _session.value!.user;
    return Chat(
      id: id,
      content: content,
      broadcastId: broadcastId,
      createdAt: createdAt,
      senderId: senderId,
      fullName: user.fullName,
      imageUrl: user.imageUrl,
      updatedAt: updatedAt,
      status: status,
      sender: ChatSender(
        id: senderId,
        fullName: user.fullName,
        imageUrl: user.imageUrl,
      ),
    );
  }
}
