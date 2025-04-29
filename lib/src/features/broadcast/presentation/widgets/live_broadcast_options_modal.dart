import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meno_design_system/meno_design_system.dart';
import 'package:meno_flutter/src/features/broadcast/broadcast.dart';

class LiveBroadcastOptionsModal extends ConsumerWidget {
  const LiveBroadcastOptionsModal({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = MenoColorScheme.of(context);
    final bottom = MediaQuery.viewPaddingOf(context).bottom;

    return Padding(
      padding: EdgeInsets.fromLTRB(16, 0, 16, bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const BroadcastArtworkWidget(
            boxPadding: EdgeInsets.zero,
            outerBoxHeight: 96,
            outerBoxWidth: 96,
          ),
          const MenoSpacer.v(Insets.sm),
          const BroadcastTitleWidget(maxLines: 1),
          const MenoSpacer.v(Insets.xs),
          const Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: Insets.xs,
              children: [
                BroadcastCreatorWidget(),
                MenoTag.live(size: MenoSize.sm),
              ],
            ),
          ),
          const MenoSpacer.v(Insets.xxlg),
          MenoListTile.small(
            headline: 'Share',
            leading: const Icon(MIcons.share, size: 20),
            iconColor: colors.labelPrimary,
          ),
          const MenoSpacer.v(Insets.sm),
          MenoListTile.small(
            headline: 'Copy link',
            leading: const Icon(MIcons.link_02, size: 20),
            iconColor: colors.labelPrimary,
          ),
          const MenoSpacer.v(Insets.lg),
        ],
      ),
    );
  }
}

extension LiveBroadcastOptionsModalX on BuildContext {
  Future<void> showLiveBroadcastOptions() {
    return showModalBottomSheet(
      context: this,
      isScrollControlled: true,
      useRootNavigator: true,
      builder: (context) => const LiveBroadcastOptionsModal(),
    );
  }
}
