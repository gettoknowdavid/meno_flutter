import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meno_flutter/src/config/config.dart' show Paginated;

part 'paginated_broadcasts.g.dart';

@JsonSerializable(genericArgumentFactories: true)
final class PaginatedBroadcasts<BroadcastDto>
    with EquatableMixin, Paginated<BroadcastDto?> {
  const PaginatedBroadcasts({
    required this.broadcasts,
    required this.totalPages,
    required this.totalItems,
    required this.currentPage,
  });

  factory PaginatedBroadcasts.fromJson(
    Map<String, dynamic> json,
    BroadcastDto Function(Object?) fromJsonT,
  ) => _$PaginatedBroadcastsFromJson(json, fromJsonT);

  final List<BroadcastDto?> broadcasts;

  @override
  List<BroadcastDto?> get items => broadcasts;

  @override
  final int totalPages;

  @override
  final int totalItems;

  @override
  final int currentPage;

  @override
  List<Object?> get props => [broadcasts, totalItems, totalPages, currentPage];

  Map<String, dynamic> toJson(Object? Function(BroadcastDto value) toJsonT) =>
      _$PaginatedBroadcastsToJson(this, toJsonT);

  @override
  bool? get stringify => true;
}

@JsonSerializable(genericArgumentFactories: true)
final class PaginatedParticipants<ParticipantDto>
    with EquatableMixin, Paginated<ParticipantDto?> {
  const PaginatedParticipants({
    required this.participants,
    required this.totalPages,
    required this.totalItems,
    required this.currentPage,
  });

  factory PaginatedParticipants.fromJson(
    Map<String, dynamic> json,
    ParticipantDto Function(Object?) fromJsonT,
  ) => _$PaginatedParticipantsFromJson(json, fromJsonT);

  @JsonKey(name: 'broadcastListeners')
  final List<ParticipantDto?> participants;

  @override
  List<ParticipantDto?> get items => participants;

  @override
  final int totalPages;

  @override
  final int totalItems;

  @override
  final int currentPage;

  @override
  List<Object?> get props => [
    participants,
    totalItems,
    totalPages,
    currentPage,
  ];

  Map<String, dynamic> toJson(Object? Function(ParticipantDto value) toJsonT) =>
      _$PaginatedParticipantsToJson(this, toJsonT);

  @override
  bool? get stringify => true;
}
