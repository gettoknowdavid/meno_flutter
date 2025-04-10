import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meno_flutter/src/features/broadcast/broadcast.dart'
    show BroadcastDto;

part 'join_broadcast_dto.g.dart';

@JsonSerializable()
class JoinBroadcastDto with EquatableMixin {
  const JoinBroadcastDto({
    required this.broadcastToken,
    required this.broadcast,
  });

  factory JoinBroadcastDto.fromJson(Map<String, dynamic> json) =>
      _$JoinBroadcastDtoFromJson(json);

  Map<String, dynamic> toJson() => _$JoinBroadcastDtoToJson(this);

  final String broadcastToken;
  final BroadcastDto broadcast;

  @override
  List<Object?> get props => [broadcastToken, broadcast];

  @override
  bool? get stringify => true;
}
