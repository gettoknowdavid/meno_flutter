import 'package:equatable/equatable.dart';
import 'package:meno_flutter/src/features/broadcast/domain/entities/entities.dart';
import 'package:meno_flutter/src/shared/shared.dart';

class Broadcast with EquatableMixin {
  const Broadcast({
    required this.id,
    required this.title,
    required this.description,
    this.status = BroadacstStatus.inactive,
    this.broadcastToken,
    this.creatorId,
    this.creator,
    this.fullName,
    this.imageUrl,
    this.startTime,
    this.endTime,
    this.createdAt,
    this.deleted,
    this.liveListeners,
    this.totalListeners,
    this.creatorFullName,
    this.creatorBio,
    this.creatorImageUrl,
  });

  final ID id;
  final SingleLineString title;
  final MultiLineString description;
  final BroadacstStatus status;
  final String? broadcastToken;
  final ID? creatorId;
  final Participant? creator;
  final SingleLineString? fullName;
  final String? imageUrl;
  final DateTime? startTime;
  final DateTime? endTime;
  final DateTime? createdAt;
  final dynamic deleted;
  final int? liveListeners;
  final int? totalListeners;
  final SingleLineString? creatorFullName;
  final MultiLineString? creatorBio;
  final String? creatorImageUrl;

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    broadcastToken,
    status,
    creatorId,
    creator,
    fullName,
    imageUrl,
    startTime,
    endTime,
    createdAt,
    deleted,
    liveListeners,
    totalListeners,
    creatorFullName,
    creatorBio,
    creatorImageUrl,
  ];

  @override
  bool? get stringify => true;
}
