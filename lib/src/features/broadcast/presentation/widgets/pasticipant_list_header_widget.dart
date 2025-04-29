import 'package:flutter/material.dart';
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
          Expanded(
            child: Row(
              children: [
                Icon(MIcons.hearing, size: 18, color: colors.labelDisabled),
                const MenoSpacer.h(Insets.xs),
                MenoText.caption('23', color: colors.labelDisabled),
              ],
            ),
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
