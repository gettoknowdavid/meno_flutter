import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meno_design_system/meno_design_system.dart';

class BroadcastTimerWidget extends ConsumerWidget {
  const BroadcastTimerWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = MenoColorScheme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: Insets.sm,
      children: [
        MenoText.caption(
          '00:30:36',
          color: colors.labelDisabled,
          weight: MenoFontWeight.regular,
        ),
        MenoText.caption(
          'Started 5 mins ago',
          color: colors.labelDisabled,
          weight: MenoFontWeight.regular,
        ),
      ],
    );
  }
}
