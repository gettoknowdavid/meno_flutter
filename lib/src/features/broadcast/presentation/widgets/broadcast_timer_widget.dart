import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meno_design_system/meno_design_system.dart';
import 'package:meno_flutter/src/features/broadcast/application/timer_notifier.dart';
import 'package:meno_flutter/src/shared/presentation/widgets/meno_dot.dart';
import 'package:meno_flutter/src/utils/timer_helper.dart';

class BroadcastTimerWidget extends ConsumerWidget {
  const BroadcastTimerWidget({this.showTimeAgo = true, super.key});
  final bool showTimeAgo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = MenoColorScheme.of(context);
    final timer = ref.watch(timerNotifierProvider);

    final elapsed = timer.elapsed;
    final isRunning = timer.isRunning;

    final hoursStr = elapsed.hoursFormatted;
    final minutesStr = elapsed.minutesFormatted;
    final secondsStr = elapsed.secondsFormatted;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: Insets.sm,
      children: [
        MenoText.caption(
          '$hoursStr:$minutesStr:$secondsStr',
          color: colors.labelDisabled,
          weight: MenoFontWeight.regular,
        ),
        if (isRunning && showTimeAgo) ...[
          const MenoDot(dimension: 4),
          MenoText.caption(
            elapsed.timeAgo,
            color: colors.labelDisabled,
            weight: MenoFontWeight.regular,
          ),
        ],
      ],
    );
  }
}
