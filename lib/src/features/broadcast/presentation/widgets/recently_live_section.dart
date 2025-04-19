import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meno_design_system/meno_design_system.dart';
import 'package:meno_flutter/src/config/config.dart';
import 'package:meno_flutter/src/features/broadcast/broadcast.dart';
import 'package:meno_flutter/src/routing/routing.dart';
import 'package:skeletonizer/skeletonizer.dart';

class RecentlyLiveSection extends HookConsumerWidget {
  const RecentlyLiveSection({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final broadcastsAsync = ref.watch(recentlyLiveBroadcastsProvider);

    return MenoSection(
      title: 'Recently live',
      emoji: MenoAssets.emojis.highVoltage.image(),
      onSeeAll: () {
        const BroadcastsRoute(
          type: BroadcastsPageType.recently,
          orderBy: OrderBy.DESC,
          sortBy: 'endTime',
          endTimeExists: true,
          include: 'totalListeners',
        ).push(context);
      },
      child: switch (broadcastsAsync) {
        AsyncData(:final value) => _ListWidget(value),
        AsyncLoading() => _ListWidget(fakeBroadcasts, isLoading: true),
        _ => const Center(child: MenoText.body('Nothing to see here')),
      },
    );
  }
}

class _ListWidget extends StatelessWidget {
  const _ListWidget(this.broadcasts, {this.isLoading = false});
  final List<Broadcast?> broadcasts;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    if (broadcasts.isEmpty) {
      return const Center(child: MenoText.body('Nothing to see here'));
    }

    return Skeletonizer(
      enabled: isLoading,
      child: ListView.separated(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 48),
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        separatorBuilder: (context, index) => const MenoSpacer.h(24),
        itemCount: broadcasts.length,
        itemBuilder: (context, index) {
          final broadcast = broadcasts[index]!;
          return MenoRecentlyLiveCard(
            key: ValueKey(broadcasts[index]?.id),
            title: broadcast.title.getOrCrash(),
            creator: broadcast.fullName?.getOrNull() ?? '',
            imageUrl: broadcast.imageUrl,
          );
        },
      ),
    );
  }
}
