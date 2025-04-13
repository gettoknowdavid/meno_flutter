import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meno_design_system/meno_design_system.dart';
import 'package:meno_flutter/src/features/broadcast/broadcast.dart' show MenoSection;

class LiveForYouSection extends HookConsumerWidget {
  const LiveForYouSection({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = MenoColorScheme.of(context);
    return MenoSection(
      title: 'Live for you',
      emoji: MenoAssets.emojis.sparkles.image(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: Insets.lg),
        height: 112,
        child: Row(
          spacing: 20,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MenoText.caption(
                    '''Hello there! You are not subscribed \nto any broadcasts yet.''',
                    weight: MenoFontWeight.regular,
                    color: colors.labelDisabled,
                  ),
                  const MenoSpacer.v(Insets.lg),
                  SizedBox(
                    height: 32,
                    child: MenoSecondaryButton.icon(
                      icon: const Icon(MIcons.compass),
                      label: const Text('Discover'),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
            MenoAssets.images.liveForYou.image(fit: BoxFit.fill),
          ],
        ),
      ),
    );
  }
}
