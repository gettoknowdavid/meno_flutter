import 'package:equatable/equatable.dart';
import 'package:meno_flutter/src/features/chat/domain/entities/chat_sender.dart';
import 'package:meno_flutter/src/shared/shared.dart';

final class Chat with EquatableMixin {
  const Chat({
    required this.id,
    required this.content,
    required this.broadcastId,
    required this.createdAt,
    this.sender,
    this.senderId,
    this.fullName,
    this.imageUrl,
    this.updatedAt,
  });

  final ID id;
  final MultiLineString content;
  final ChatSender? sender;
  final ID? senderId;
  final SingleLineString? fullName;
  final String? imageUrl;
  final ID broadcastId;
  final DateTime createdAt;
  final DateTime? updatedAt;

  @override
  List<Object?> get props => [
    id,
    content,
    sender,
    senderId,
    fullName,
    imageUrl,
    broadcastId,
    createdAt,
    updatedAt,
  ];
  Chat copyWith({
    ID? id,
    MultiLineString? content,
    ChatSender? sender,
    ID? senderId,
    SingleLineString? fullName,
    String? imageUrl,
    ID? broadcastId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Chat(
      id: id ?? this.id,
      content: content ?? this.content,
      sender: sender ?? this.sender,
      senderId: senderId ?? this.senderId,
      fullName: fullName ?? this.fullName,
      imageUrl: imageUrl ?? this.imageUrl,
      broadcastId: broadcastId ?? this.broadcastId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
