import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meno_flutter/src/features/profile/domain/domain.dart';

part 'profile_stats_dto.g.dart';

@JsonSerializable()
final class ProfileStatsDto with EquatableMixin {
  const ProfileStatsDto({
    this.subscribers = 0,
    this.subscriptions = 0,
    this.broadcasts = 0,
  });

  factory ProfileStatsDto.fromJson(Map<String, dynamic> json) =>
      _$ProfileStatsDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileStatsDtoToJson(this);

  final int subscribers;
  final int subscriptions;
  final int broadcasts;

  @override
  List<Object?> get props => [subscribers, subscriptions, broadcasts];

  @override
  bool get stringify => true;
}

extension ProfileStatsToDtoX on ProfileStats {
  ProfileStatsDto get toDto {
    return ProfileStatsDto(
      broadcasts: broadcasts,
      subscribers: subscribers,
      subscriptions: subscriptions,
    );
  }
}

extension ProfileStatsToDomainX on ProfileStatsDto {
  ProfileStats get toDomain {
    return ProfileStats(
      broadcasts: broadcasts,
      subscribers: subscribers,
      subscriptions: subscriptions,
    );
  }
}
