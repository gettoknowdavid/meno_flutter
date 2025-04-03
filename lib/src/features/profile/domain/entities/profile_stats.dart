import 'package:equatable/equatable.dart';

final class ProfileStats with EquatableMixin {
  const ProfileStats({
    this.subscribers = 0,
    this.subscriptions = 0,
    this.broadcasts = 0,
  });

  final int subscribers;
  final int subscriptions;
  final int broadcasts;

  ProfileStats copyWith({
    int? subscribers,
    int? subscriptions,
    int? broadcasts,
  }) {
    return ProfileStats(
      subscribers: subscribers ?? this.subscribers,
      subscriptions: subscriptions ?? this.subscriptions,
      broadcasts: broadcasts ?? this.broadcasts,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [subscribers, subscriptions, broadcasts];
}
