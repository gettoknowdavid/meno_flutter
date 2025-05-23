import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meno_design_system/meno_design_system.dart';
import 'package:meno_flutter/src/features/broadcast/broadcast.dart';
import 'package:skeletonizer/skeletonizer.dart';

class LiveBroadcastTab extends HookConsumerWidget {
  const LiveBroadcastTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useTabController(initialLength: 2);

    return Column(
      children: [
        const Flexible(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 24, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                BroadcastArtworkWidget(key: Key('LiveBroadcastArtwork')),
                MenoSpacer.v(Insets.sm),
                BroadcastTimerWidget(key: Key('LiveBroadcastTimer')),
                MenoSpacer.v(Insets.sm),
                BroadcastTitleWidget(key: Key('LiveBroadcastTitle')),
                MenoSpacer.v(Insets.sm),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: Insets.sm,
                  children: [
                    BroadcastCreatorWidget(key: Key('LiveBroadcastCreator')),
                    BroadcastStatusWidget(key: Key('LiveBroadcastStatus')),
                  ],
                ),
                MenoSpacer.v(Insets.xxlg),
                BroadcastControlButtons(key: Key('LiveBroadcastControls')),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 40,
          child: Padding(
            padding: const EdgeInsets.only(top: Insets.sm),
            child: MenoTabBar.normal(
              isScrollable: false,
              tabs: const [MenoTab(text: 'Listening'), MenoTab(text: 'About')],
              controller: controller,
            ),
          ),
        ),
        Expanded(
          child: MenoTabBarView(
            controller: controller,
            children: const [
              _BroadcastListeningTab(key: Key('LiveBroadcastParticipantsTab')),
              _BroadcastAboutTab(key: Key('LiveBroadcastAboutTab')),
            ],
          ),
        ),
      ],
    );
  }
}

class _BroadcastListeningTab extends ConsumerWidget {
  const _BroadcastListeningTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Column(
      children: [
        MenoSpacer.v(Insets.xlg),
        PasticipantListHeaderWidget(),
        MenoSpacer.v(Insets.lg),
        Expanded(child: ParticipantListWidget()),
      ],
    );
  }
}

class _BroadcastAboutTab extends ConsumerWidget {
  const _BroadcastAboutTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = MenoColorScheme.of(context);
    final state = ref.watch(liveBroadcastProvider);
    final isLoading = state.status == MenoLiveStatus.inProgress;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: Insets.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const MenoSpacer.v(Insets.xlg),
          const Row(
            spacing: Insets.sm,
            children: [
              Icon(MIcons.menu_03, size: 16),
              MenoText.subheading(
                'About broadcast',
                weight: MenoFontWeight.bold,
              ),
            ],
          ),
          const MenoSpacer.v(Insets.lg),
          MenoText.caption(
            isLoading
                ? BoneMock.longParagraph
                : state.broadcast.description.getOrCrash(),
            weight: MenoFontWeight.regular,
            color: colors.labelDisabled,
          ),
        ],
      ),
    );
  }
}
