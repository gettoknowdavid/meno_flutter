import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meno_design_system/meno_design_system.dart';
import 'package:meno_flutter/src/features/broadcast/broadcast.dart' show MenoSection;

class NowLiveSection extends HookConsumerWidget {
  const NowLiveSection({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MenoSection(
      title: 'Now live',
      emoji: MenoAssets.emojis.flame.image(),
      child: const SizedBox.shrink(),
    );
  }
}
