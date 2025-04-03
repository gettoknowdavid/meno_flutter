import 'package:equatable/equatable.dart';
import 'package:meno_flutter/src/features/profile/domain/entities/profile_stats.dart';
import 'package:meno_flutter/src/shared/shared.dart';

final class Profile with EquatableMixin {
  const Profile({
    required this.id,
    required this.fullName,
    required this.bio,
    this.stats,
    this.imageUrl,
    this.role,
    this.isSubscribedToUser,
    this.numberOfBroadcasts,
    this.numberOfSubscribers,
    this.numberOfSubscriptions,
    this.subscribed,
  });

  final Id id;
  final FullName fullName;
  final Bio bio;
  final ProfileStats? stats;
  final String? imageUrl;
  final AuthRole? role;
  final bool? isSubscribedToUser;
  final int? numberOfBroadcasts;
  final int? numberOfSubscribers;
  final int? numberOfSubscriptions;
  final bool? subscribed;

  Profile copyWith({
    Id? id,
    FullName? fullName,
    Bio? bio,
    ProfileStats? stats,
    String? imageUrl,
    AuthRole? role,
    bool? isSubscribedToUser,
    int? numberOfBroadcasts,
    int? numberOfSubscribers,
    int? numberOfSubscriptions,
    bool? subscribed,
  }) {
    return Profile(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      bio: bio ?? this.bio,
      stats: stats ?? this.stats,
      imageUrl: imageUrl ?? this.imageUrl,
      role: role ?? this.role,
      isSubscribedToUser: isSubscribedToUser ?? this.isSubscribedToUser,
      numberOfBroadcasts: numberOfBroadcasts ?? this.numberOfBroadcasts,
      numberOfSubscribers: numberOfSubscribers ?? this.numberOfSubscribers,
      numberOfSubscriptions:
          numberOfSubscriptions ?? this.numberOfSubscriptions,
      subscribed: subscribed ?? this.subscribed,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [
    id,
    bio,
    role,
    fullName,
    imageUrl,
    stats,
    isSubscribedToUser,
  ];
}
