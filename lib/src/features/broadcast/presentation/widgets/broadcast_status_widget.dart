import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meno_design_system/meno_design_system.dart';
import 'package:meno_flutter/src/features/broadcast/application/live_notifier.dart';

class BroadcastStatusWidget extends ConsumerWidget {
  const BroadcastStatusWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final status = ref.watch(liveNotifierProvider);
    return switch (status) {
      const MenoLive() => const MenoTag.live(size: MenoSize.sm),
      const MenoReconnecting() => const MenoTag.reconnecting(size: MenoSize.sm),
      const MenoLive() => const MenoTag.inProgress(
        'CONNECTING',
        size: MenoSize.sm,
      ),
      _ => const MenoTag.offAir(size: MenoSize.sm),
    };
  }
}
