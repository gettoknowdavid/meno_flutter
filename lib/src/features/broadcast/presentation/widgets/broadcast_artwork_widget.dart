import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meno_design_system/meno_design_system.dart';
import 'package:meno_flutter/src/features/broadcast/broadcast.dart';

class BroadcastArtworkWidget extends ConsumerWidget {
  const BroadcastArtworkWidget({
    this.radius = 48,
    this.outerBoxHeight = 144,
    this.outerBoxWidth = 152,
    this.boxPadding = const EdgeInsets.symmetric(
      horizontal: 28,
      vertical: Insets.lg,
    ),
    super.key,
  });

  final double radius;
  final double? outerBoxHeight;
  final double? outerBoxWidth;
  final EdgeInsetsGeometry? boxPadding;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(liveBroadcastProvider);

    return Container(
      height: outerBoxHeight,
      width: outerBoxWidth,
      padding: boxPadding,
      alignment: Alignment.center,
      child: MenoAvatar(
        radius: radius,
        url: state.broadcast.imageUrl,
        isLoading: state.status == MenoLiveStatus.inProgress,
      ),
    );
  }
}
