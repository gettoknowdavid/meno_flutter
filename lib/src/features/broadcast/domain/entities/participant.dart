import 'package:equatable/equatable.dart';
import 'package:meno_flutter/src/features/broadcast/domain/entities/entities.dart';
import 'package:meno_flutter/src/shared/shared.dart';

class Participant with EquatableMixin {
  const Participant({
    required this.id,
    required this.fullName,
    this.bio,
    this.imageUrl,
    this.broadcastId,
    this.role,
    this.numberOfListeners,
    this.isHostDisconnected,
    this.joinedAt,
    this.disconnectedAt,
  });

  final ID id;
  final SingleLineString fullName;
  final MultiLineString? bio;
  final String? imageUrl;
  final ID? broadcastId;
  final ParticipantRole? role;
  final int? numberOfListeners;
  final bool? isHostDisconnected;
  final DateTime? joinedAt;
  final DateTime? disconnectedAt;

  @override
  List<Object?> get props => [
    id,
    fullName,
    bio,
    imageUrl,
    broadcastId,
    role,
    numberOfListeners,
    isHostDisconnected,
    joinedAt,
    disconnectedAt,
  ];

  @override
  bool? get stringify => true;
}
