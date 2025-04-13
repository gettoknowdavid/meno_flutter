import 'package:flutter/material.dart';
import 'package:meno_design_system/meno_design_system.dart';

class BroadcastFormFieldItem extends StatelessWidget {
  const BroadcastFormFieldItem({
    required this.title,
    required this.description,
    required this.trailing,
    super.key,
  });

  final String title;
  final String description;
  final Widget trailing;
  @override
  Widget build(BuildContext context) {
    final colors = MenoColorScheme.of(context);
    return Column(
      spacing: Insets.xs,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          height: 48,
          padding: const EdgeInsets.symmetric(
            horizontal: Insets.lg,
            vertical: Insets.md,
          ),
          decoration: BoxDecoration(
            color: colors.componentSecondary,
            borderRadius: MenoBorderRadius.sm,
          ),
          child: Row(
            spacing: Insets.lg,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Expanded(child: MenoText.caption(title)), trailing],
          ),
        ),
        MenoText.caption(
          description,
          color: colors.labelHelp,
          weight: MenoFontWeight.regular,
        ),
      ],
    );
  }
}
