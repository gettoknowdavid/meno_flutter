import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:meno_design_system/meno_design_system.dart';
import 'package:meno_flutter/src/config/config.dart';
import 'package:meno_flutter/src/features/broadcast/application/now_live_broadcasts.dart';
import 'package:meno_flutter/src/features/broadcast/broadcast.dart'
    show Broadcast, BroadcastException, BroadcastsPageType, MenoSection;
import 'package:meno_flutter/src/routing/router.dart';
import 'package:skeletonizer/skeletonizer.dart';

class NowLiveSection extends HookConsumerWidget {
  const NowLiveSection({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final broadcastsAsync = ref.watch(nowLiveBroadcastsProvider);

    return MenoSection(
      title: 'Now live',
      emoji: MenoAssets.emojis.flame.image(),
      onSeeAll: () {
        const BroadcastsRoute(
          type: BroadcastsPageType.now,
          orderBy: OrderBy.ASC,
          sortBy: 'startTime',
          endTimeExists: false,
          startTimeExists: true,
          include: 'totalListeners',
          status: 'active',
        ).push(context);
      },
      child: switch (broadcastsAsync) {
        AsyncData(:final value) => _ListWidget(value),
        AsyncLoading() => _ListWidget(fakeBroadcasts, isLoading: true),
        AsyncError(:final error) => MenoErrorWidget(
          (error as BroadcastException).message,
        ),
        _ => const SizedBox.shrink(),
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
      return const MenoEmptyWidget(description: 'No recently live broadcasts');
    }

    return Skeletonizer(
      enabled: isLoading,
      child: ListView.separated(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        separatorBuilder: (context, index) => const MenoSpacer.h(24),
        itemCount: broadcasts.length,
        itemBuilder: (context, index) {
          final broadcast = broadcasts[index]!;
          return MenoLiveCard(
            key: ValueKey(broadcasts[index]?.id),
            title: broadcast.title.getOrCrash(),
            creator: broadcast.fullName?.getOrNull() ?? '',
            imageUrl: broadcast.imageUrl,
            numberOfParticipants: broadcast.totalListeners ?? 0,
          );
        },
      ),
    );
  }
}

class MenoLiveCard extends StatelessWidget {
  const MenoLiveCard({
    required this.title,
    required this.creator,
    super.key,
    this.imageUrl,
    this.numberOfParticipants = 0,
    this.onTap,
  });

  final String title;
  final String creator;
  final String? imageUrl;
  final int numberOfParticipants;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = MenoColorScheme.of(context);
    const borderRadius = MenoBorderRadius.lg;
    final count = NumberFormat.compact().format(numberOfParticipants);
    return InkWell(
      borderRadius: borderRadius,
      child: Card(
        margin: EdgeInsets.zero,
        color: colors.cardPrimary,
        shape: const RoundedRectangleBorder(borderRadius: borderRadius),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(Insets.lg),
              child: SizedBox.square(
                dimension: 144,
                child: Column(
                  children: [
                    MenoNetworkImage(
                      imageUrl,
                      key: const Key('LiveBroadcastCardImage'),
                      height: 88,
                      width: 88,
                      borderRadius: MenoBorderRadius.circle,
                    ),
                    const MenoSpacer.v(Insets.md),
                    MenoText.caption(
                      title,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const MenoSpacer.v(Insets.xs),
                    MenoText.caption(
                      creator,
                      color: colors.labelPlaceholder,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      weight: MenoFontWeight.regular,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(top: 6, left: 8, child: MenoTag.live(extraText: count)),
          ],
        ),
      ),
    );
  }
}
