import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meno_design_system/meno_design_system.dart';
import 'package:meno_flutter/src/features/broadcast/broadcast.dart';
import 'package:meno_flutter/src/routing/routing.dart';

class LiveBroadcastOptionsModal extends ConsumerWidget {
  const LiveBroadcastOptionsModal({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = MenoColorScheme.of(context);
    final bottom = MediaQuery.viewPaddingOf(context).bottom;
    final broadcast = ref.watch(liveBroadcastProvider).broadcast;

    // This will be used to check if the edit button is visible
    //
    // For now, we will have to utitlize the availability of the
    // `broadcastToken`
    //
    // If this token is available, it means the broadcast has been started
    // and so it cannot be edited again on this live broadcast page.
    //
    final isEditable = broadcast.broadcastToken == null;
    final id = broadcast.id;

    return Padding(
      padding: EdgeInsets.fromLTRB(16, 0, 16, bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const BroadcastArtworkWidget(
            key: Key('LiveBroadcastArtwork'),
            boxPadding: EdgeInsets.zero,
            outerBoxHeight: 96,
            outerBoxWidth: 96,
          ),
          const MenoSpacer.v(Insets.sm),
          const BroadcastTitleWidget(
            key: Key('LiveBroadcastTitle'),
            maxLines: 1,
          ),
          const MenoSpacer.v(Insets.xs),
          const Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: Insets.xs,
              children: [
                BroadcastCreatorWidget(key: Key('LiveBroadcastCreator')),
                BroadcastStatusWidget(key: Key('LiveBroadcastStatus')),
              ],
            ),
          ),
          const MenoSpacer.v(Insets.xxlg),
          if (isEditable) ...[
            const MenoSpacer.v(Insets.sm),
            MenoListTile.small(
              headline: 'Edit',
              leading: const Icon(MIcons.edit_05, size: 20),
              iconColor: colors.labelPrimary,
              onTap: () => BroadcastDetailsRoute(id.getOrCrash()).push(context),
            ),
          ],
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
          if (isEditable) ...[
            const MenoSpacer.v(Insets.sm),
            MenoListTile.small(
              headline: 'Delete',
              leading: const Icon(MIcons.trash, size: 20),
              iconColor: colors.errorBase,
              headlineColor: colors.errorBase,
            ),
          ],
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
