import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meno_design_system/meno_design_system.dart';
import 'package:meno_flutter/features/auth/auth.dart';

class PasswordRulesWidgetTracker extends StatelessWidget {
  const PasswordRulesWidgetTracker({super.key});
  @override
  Widget build(BuildContext context) {
    const errors = PasswordValidationError.values;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const MenoLinearProgressIndicator(value: 0),
        const MenoSpacer.v(Insets.xs),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MenoText.nano('Your password must include:'),
            MenoText.nano('Good'),
          ],
        ),
        const MenoSpacer.v(Insets.md),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: errors.map(PasswordRuleWidget.new).toList(),
        ),
      ],
    );
  }
}

class PasswordRuleWidget extends ConsumerWidget {
  const PasswordRuleWidget(this.error, {super.key});
  final PasswordValidationError error;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = MenoColorScheme.of(context);
    final password = ref.watch(registerFormProvider.select((s) => s.password));
    final isCurrentError = password.errors.contains(error);

    final effectiveColor =
        password.isPure
            ? colors.labelPlaceholder
            : isCurrentError
            ? colors.errorBase
            : colors.successBase;

    return SizedBox(
      height: 38,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MenoText.subheading(error.title, color: effectiveColor),
          MenoText.nano(error.subtitle, color: effectiveColor),
        ],
      ),
    );
  }
}
