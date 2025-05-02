import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meno_design_system/meno_design_system.dart';
import 'package:meno_flutter/src/features/broadcast/broadcast.dart';

class PasticipantListHeaderWidget extends StatelessWidget {
  const PasticipantListHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = MenoColorScheme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: Insets.lg),
      height: 34,
      child: Row(
        spacing: Insets.sm,
        children: [
          const Expanded(
            child: _ParticipantCountWidget(key: Key('LiveParticipantsCount')),
          ),
          MenoPrimaryButton.icon(
            label: const Text('Expand'),
            icon: const Icon(MIcons.expand_01),
            style: FilledButton.styleFrom(
              backgroundColor: colors.componentPrimary,
              foregroundColor: colors.labelDisabled,
              iconColor: colors.labelDisabled,
              padding: const EdgeInsets.symmetric(
                horizontal: Insets.md,
                vertical: Insets.sm,
              ),
              iconSize: 16,
              shape: const RoundedRectangleBorder(
                borderRadius: MenoBorderRadius.circle,
              ),
            ),
            onPressed: () => context.showParticipantListModal(),
          ),
        ],
      ),
    );
  }
}

class _ParticipantCountWidget extends ConsumerWidget {
  const _ParticipantCountWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = MenoColorScheme.of(context);
    final participants = ref.watch(participantsProvider);

    return Row(
      children: [
        Icon(MIcons.hearing, size: 18, color: colors.labelDisabled),
        const MenoSpacer.h(Insets.xs),
        switch (participants) {
          AsyncData(:final value) => MenoText.caption(
            value.length.toString(),
            color: colors.labelDisabled,
          ),
          _ => MenoText.caption('0', color: colors.labelDisabled),
        },
      ],
    );
  }
}
