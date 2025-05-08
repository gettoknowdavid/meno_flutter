import 'dart:async';
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meno_flutter/src/config/config.dart';
import 'package:meno_flutter/src/features/auth/auth.dart';
import 'package:meno_flutter/src/features/chat/chat.dart';
import 'package:meno_flutter/src/services/socket/socket.dart';
import 'package:meno_flutter/src/shared/shared.dart' show ID, MultiLineString;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'send_chat_message.g.dart';

@riverpod
Future<void> sendChatMessage(
  Ref ref, {
  required ID broadcastId,
  required MultiLineString content,
}) async {
  if (!broadcastId.isValid) {
    log('sendMessage aborted: Invalid broadcast id.');
    return;
  }

  final user = ref.read(sessionProvider).value?.user;
  final contentString = content.getOrCrash();
  
  if (user == null || contentString.trim().isEmpty) {
    log('sendMessage aborted: User not logged in or content empty.');
    return;
  }

  final chatListNotifier = ref.read(chatListProvider.notifier);
  final socket = ref.read(socketProvider.notifier);
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
