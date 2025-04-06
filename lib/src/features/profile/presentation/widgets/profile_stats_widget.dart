import 'package:flutter/material.dart';
import 'package:meno_design_system/meno_design_system.dart';
import 'package:meno_flutter/src/features/profile/profile.dart';

class ProfileStatsWidget extends StatelessWidget {
  const ProfileStatsWidget({required this.stats, super.key});
  final ProfileStats? stats;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 46,
      child: Row(
        children: [
          const SizedBox(width: 2),
          _StatsItem(title: 'Broadcasts', count: stats?.broadcasts ?? 0),
          const Spacer(),
          _StatsItem(title: 'Subscribers', count: stats?.subscribers ?? 0),
          const Spacer(),
          _StatsItem(title: 'Subscriptions', count: stats?.subscriptions ?? 0),
          const SizedBox(width: 2),
        ],
      ),
    );
  }
}

class _StatsItem extends StatelessWidget {
  const _StatsItem({required this.title, this.count = 0});
  final String title;
  final int count;

  @override
  Widget build(BuildContext context) {
    final colors = MenoColorScheme.of(context);
    return SizedBox(
      height: 46,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MenoText.heading3(count.toString()),
          MenoText.micro(title, color: colors.labelPlaceholder),
        ],
      ),
    );
  }
}
