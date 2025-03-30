import 'package:flutter/material.dart';
import 'package:meno_design_system/meno_design_system.dart';

class AuthOrDivider extends StatelessWidget {
  const AuthOrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = MenoColorScheme.of(context);
    return Row(
      spacing: Insets.xs,
      children: [
        Expanded(child: Divider(height: 1, color: colors.strokeSoft)),
        MenoText.body(
          'Or',
          color: colors.componentSecondary,
          textAlign: TextAlign.center,
        ),
        Expanded(child: Divider(height: 1, color: colors.strokeSoft)),
      ],
    );
  }
}
