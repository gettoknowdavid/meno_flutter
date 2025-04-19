import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meno_design_system/meno_design_system.dart';
import 'package:meno_flutter/src/config/config.dart'
    show OrderBy, fakeBroadcasts;
import 'package:meno_flutter/src/features/broadcast/broadcast.dart';
import 'package:skeletonizer/skeletonizer.dart' show BoneMock, Skeletonizer;

class RecentlyLiveBroadcastsListWidget extends HookConsumerWidget {
  const RecentlyLiveBroadcastsListWidget({required this.broadcasts, super.key});
  final AsyncValue<BroadcastsState> broadcasts;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = useScrollController();
    final notifier = ref.read(
      broadcastsProvider(
        sortBy: 'endTime',
        orderBy: OrderBy.DESC,
        endTimeExists: true,
      ).notifier,
    );

    Future<void> listener() async {
      final maxScroll = scrollController.position.maxScrollExtent;
      final currentScroll = scrollController.position.pixels;
      const delta = 120.0;
      if (maxScroll - currentScroll <= delta) {
        await notifier.fetchMore();
      }
    }

    useEffect(() {
      scrollController.addListener(listener);
      return () => scrollController.removeListener(listener);
    }, [scrollController]);

    switch (broadcasts) {
      case AsyncLoading():
        return _ListWidget(broadcasts: fakeBroadcasts, isLoading: true);
      case AsyncError(:final error):
        return MenoText.body(error.toString());
      case AsyncData(:final value):
        return _ListWidget(
          broadcasts: value.broadcasts,
          scrollController: scrollController,
          moreInProgress: value.moreInProgress,
          exception: value.exception,
        );
      default:
        return const SizedBox.shrink();
    }
  }
}

class _ListWidget extends StatelessWidget {
  const _ListWidget({
    required this.broadcasts,
    this.scrollController,
    this.isLoading = false,
    this.moreInProgress = false,
    this.exception,
  });

  final List<Broadcast?> broadcasts;
  final ScrollController? scrollController;
  final bool isLoading;
  final bool moreInProgress;
  final BroadcastException? exception;

  @override
  Widget build(BuildContext context) {
    if (broadcasts.isEmpty) {
      return const Center(child: MenoText.body('Nothing to see here'));
    }

    final itemCount =
        broadcasts.length + (moreInProgress || exception != null ? 1 : 0);

    return Skeletonizer(
      enabled: isLoading,
      child: ListView.separated(
        padding: const EdgeInsets.fromLTRB(16, 30, 16, 32),
        itemCount: itemCount,
        controller: scrollController,
        separatorBuilder: (context, index) => const MenoSpacer.v(Insets.lg),
        itemBuilder: (context, index) {
          if (index == broadcasts.length) {
            if (exception != null) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Tooltip(
                    message: exception.toString(),
                    child: const Icon(Icons.error, color: Colors.red),
                  ),
                ),
              );
            }

            if (moreInProgress) {
              return Skeletonizer(
                child: MenoRecentlyLiveListTile(
                  title: BoneMock.title,
                  creator: BoneMock.fullName,
                  endTime: DateTime.now(),
                ),
              );
            }

            return const SizedBox.shrink();
          }

          final broadcast = broadcasts[index]!;
          return MenoRecentlyLiveListTile(
            title: broadcast.title.getOrCrash(),
            creator: broadcast.fullName?.getOrNull() ?? '',
            endTime: broadcast.endTime,
            imageUrl: broadcast.imageUrl,
          );
        },
      ),
    );
  }
}
