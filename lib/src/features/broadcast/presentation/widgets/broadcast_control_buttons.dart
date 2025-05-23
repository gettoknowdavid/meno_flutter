import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meno_design_system/meno_design_system.dart';
import 'package:meno_flutter/src/features/broadcast/broadcast.dart';
import 'package:meno_flutter/src/routing/routing.dart';
import 'package:meno_flutter/src/services/live_kit/live_kit.dart';
import 'package:meno_flutter/src/services/live_kit/microphone.dart';

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

class _MicrophoneButton extends ConsumerWidget {
  const _MicrophoneButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(microphoneProvider.notifier);
    final isEnabled = ref.watch(microphoneProvider);

    final colors = MenoColorScheme.of(context);
    return MenoIconButton.filled(
      isEnabled ? MIcons.microphone : MIcons.microphone_off,
      onPressed: notifier.toggleMicMute,
      color: colors.brandPrimary,
      iconSize: 20,
      fillColor: colors.brandPrimaryLighter,
      fixedSize: const Size.square(40),
    );
  }
}

class _StartStopButton extends ConsumerWidget {
  const _StartStopButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final broadcastNotifier = ref.read(liveBroadcastProvider.notifier);
    final livekit = ref.watch(liveKitProvider);
    final status = ref.watch(liveBroadcastProvider.select((s) => s.status));

    Future<void> startBroadcast() => broadcastNotifier.startBroadcast();

    Future<void> endBroadcast() async {
      final result = await const ConfirmationDialog(
        title: 'Stop broadcast?',
        description: 'Do you want to end this live broadcast?',
        isDanger: true,
        primaryActionText: 'Stop',
      ).push(context);
      if (result == true) return broadcastNotifier.endBroadcast();
    }

    void onPressed() {
      livekit.maybeWhen(
        orElse: endBroadcast,
        data: (room) {
          final isConnected = room?.isConnected ?? false;
          return isConnected ? endBroadcast() : startBroadcast();
        },
      );
    }

    return MenoDangerButton(
      onPressed: status == MenoLiveStatus.inProgress ? null : onPressed,
      variant: MenoDangerButtonVariant.lighter,
      style: FilledButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: Insets.xlg),
        shape: const RoundedRectangleBorder(
          borderRadius: MenoBorderRadius.circle,
        ),
      ),
      child: livekit.maybeWhen(
        orElse: () => const Text('Start broadcasting'),
        data: (data) {
          final isConnected = data?.isConnected ?? false;
          if (isConnected) return const Text('Stop broadcasting');
          return const Text('Start broadcasting');
        },
      ),
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
