import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meno_flutter/src/features/chat/data/dtos/chat_sender_dto.dart';
import 'package:meno_flutter/src/features/chat/domain/domain.dart';
import 'package:meno_flutter/src/shared/shared.dart';

part 'chat_dto.g.dart';

@JsonSerializable()
final class ChatDto with EquatableMixin {
  const ChatDto({
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

  factory ChatDto.fromJson(Map<String, dynamic> json) =>
      _$ChatDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ChatDtoToJson(this);

  final String id;
  final String content;
  final ChatSenderDto? sender;
  final String? senderId;
  final String? fullName;
  final String? imageUrl;
  final String broadcastId;
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
}

extension ChatToDto on Chat {
  ChatDto get toDto {
    return ChatDto(
      id: id.getOrCrash(),
      content: content.getOrCrash(),
      broadcastId: broadcastId.getOrCrash(),
      createdAt: createdAt,
      sender: sender?.toDto,
      senderId: senderId?.getOrNull(),
      fullName: fullName?.getOrNull(),
      imageUrl: imageUrl,
      updatedAt: updatedAt,
    );
  }
}

extension ChatToDomain on ChatDto {
  Chat get toDomain {
    return Chat(
      id: ID.fromString(id),
      content: MultiLineString(content),
      sender: sender?.toDomain,
      senderId: senderId != null ? ID.fromString(senderId!) : null,
      fullName: fullName != null ? SingleLineString(fullName!) : null,
      imageUrl: imageUrl,
      broadcastId: ID.fromString(broadcastId),
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
