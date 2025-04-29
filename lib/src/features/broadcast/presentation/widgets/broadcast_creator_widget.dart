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
    final broadcast = ref.watch(liveBroadcastProvider);

    final creator = switch (broadcast) {
      AsyncLoading() => 'Celebration Church Int’l',
      AsyncData(:final value) =>
        value.creator?.fullName.getOrNull() ??
            value.creatorFullName?.getOrNull() ??
            value.fullName?.getOrNull() ??
            '',
      _ => '',
    };

    return Skeletonizer(
      enabled: broadcast.isLoading,
      child: MenoText.caption(
        creator,
        color: colors.labelDisabled,
        weight: MenoFontWeight.regular,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
      ),
    );
  }
}
