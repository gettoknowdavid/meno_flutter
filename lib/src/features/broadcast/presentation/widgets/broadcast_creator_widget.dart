import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meno_design_system/meno_design_system.dart';
import 'package:meno_flutter/src/features/broadcast/broadcast.dart';
import 'package:skeletonizer/skeletonizer.dart';

class BroadcastCreatorWidget extends ConsumerWidget {
  const BroadcastCreatorWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = MenoColorScheme.of(context);

    final state = ref.watch(liveBroadcastProvider);
    final isLoading = state.status == MenoLiveStatus.inProgress;
    final broadcast = state.broadcast;

    final creator =
        broadcast.creator?.fullName.getOrNull() ??
        broadcast.creatorFullName?.getOrNull() ??
        broadcast.fullName?.getOrNull() ??
        '';

    return Skeletonizer(
      enabled: isLoading,
      child: MenoText.caption(
        isLoading ? BoneMock.title : creator,
        color: colors.labelDisabled,
        weight: MenoFontWeight.regular,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
      ),
    );
  }
}
