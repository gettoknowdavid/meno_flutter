import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meno_flutter/src/features/profile/profile.dart';
import 'package:meno_flutter/src/shared/shared.dart';

part 'profile_dto.g.dart';

@JsonSerializable()
final class ProfileDto with EquatableMixin {
  const ProfileDto({
    required this.id,
    required this.fullName,
    this.bio,
    this.stats,
    this.imageUrl,
    this.role,
    this.isSubscribedToUser,
    this.numberOfBroadcasts,
    this.numberOfSubscribers,
    this.numberOfSubscriptions,
    this.subscribed,
  });

  factory ProfileDto.fromJson(Map<String, dynamic> json) =>
      _$ProfileDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileDtoToJson(this);

  final String id;

  final String fullName;

  final String? bio;

  @JsonKey(name: '_count')
  final ProfileStatsDto? stats;

  final String? imageUrl;

  final AuthRole? role;

  final bool? isSubscribedToUser;

  final int? numberOfBroadcasts;

  final int? numberOfSubscribers;

  final int? numberOfSubscriptions;

  final bool? subscribed;

  @override
  List<Object?> get props => [
    id,
    fullName,
    bio,
    stats,
    imageUrl,
    role,
    isSubscribedToUser,
    numberOfBroadcasts,
    numberOfSubscribers,
    numberOfSubscriptions,
    subscribed,
  ];

  @override
  bool get stringify => true;
}

extension ProfileToDto on Profile {
  ProfileDto get toDto {
    return ProfileDto(
      id: id.getOrElse(''),
      fullName: fullName.value,
      bio: bio.value,
      stats: stats?.toDto,
      imageUrl: imageUrl,
      isSubscribedToUser: isSubscribedToUser,
      numberOfBroadcasts: numberOfBroadcasts,
      numberOfSubscribers: numberOfSubscribers,
      numberOfSubscriptions: numberOfSubscriptions,
      role: role,
      subscribed: subscribed,
    );
  }
}

extension ProfileToDomain on ProfileDto {
  Profile get toDomain {
    return Profile(
      id: Id.fromString(id),
      fullName: FullName.pure(fullName),
      bio: Bio.pure(bio),
      stats: stats?.toDomain,
      imageUrl: imageUrl,
      isSubscribedToUser: isSubscribedToUser,
      numberOfBroadcasts: numberOfBroadcasts,
      numberOfSubscribers: numberOfSubscribers,
      numberOfSubscriptions: numberOfSubscriptions,
      role: role,
      subscribed: subscribed,
    );
  }
}
