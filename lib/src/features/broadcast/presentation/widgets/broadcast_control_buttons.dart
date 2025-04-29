import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meno_design_system/meno_design_system.dart';
import 'package:meno_flutter/src/features/broadcast/broadcast.dart';

class BroadcastControlButtons extends ConsumerWidget {
  const BroadcastControlButtons({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const SizedBox(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: Insets.sm,
        children: [
          _MicrophoneButton(key: Key('LivebroadcastMicrophoneButton')),
          _StartStopButton(key: Key('LivebroadcastStartStopButton')),
          _OptionsButton(key: Key('LivebroadcastOptionsButton')),
        ],
      ),
    );
  }
}

class _MicrophoneButton extends StatelessWidget {
  const _MicrophoneButton({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = MenoColorScheme.of(context);
    return MenoIconButton.filled(
      MIcons.microphone,
      onPressed: () {},
      color: colors.brandPrimary,
      iconSize: 20,
      fillColor: colors.brandPrimaryLighter,
      fixedSize: const Size.square(40),
    );
  }
}

class _StartStopButton extends StatelessWidget {
  const _StartStopButton({super.key});

  @override
  Widget build(BuildContext context) {
    return MenoDangerButton(
      onPressed: () {},
      variant: MenoDangerButtonVariant.lighter,
      style: FilledButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: Insets.xlg),
        shape: const RoundedRectangleBorder(
          borderRadius: MenoBorderRadius.circle,
        ),
      ),
      child: const Text('Stop broadcasting'),
    );
  }
}

class _OptionsButton extends StatelessWidget {
  const _OptionsButton({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = MenoColorScheme.of(context);
    return MenoIconButton(
      MIcons.dots_horizontal,
      iconSize: 20,
      padding: const EdgeInsets.symmetric(horizontal: Insets.lg),
      fixedSize: const Size(52, 40),
      shape: RoundedRectangleBorder(
        side: BorderSide(width: 1.5, color: colors.strokeSoft),
        borderRadius: MenoBorderRadius.lg,
      ),
      onPressed: context.showLiveBroadcastOptions,
    );
  }
}
