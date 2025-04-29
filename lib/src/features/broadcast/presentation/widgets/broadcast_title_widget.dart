import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meno_design_system/meno_design_system.dart';
import 'package:meno_flutter/src/features/broadcast/broadcast.dart';
import 'package:skeletonizer/skeletonizer.dart';

class BroadcastTitleWidget extends ConsumerWidget {
  const BroadcastTitleWidget({this.maxLines = 2, super.key});
  final int maxLines;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final broadcast = ref.watch(liveBroadcastProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Insets.lg),
      child: Skeletonizer(
        enabled: broadcast.isLoading,
        child: MenoText.subheading(
          broadcast.valueOrNull?.title.getOrNull() ?? BoneMock.title,
          weight: MenoFontWeight.bold,
          maxLines: maxLines,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
