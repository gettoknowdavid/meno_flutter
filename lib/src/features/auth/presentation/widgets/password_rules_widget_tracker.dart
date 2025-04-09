import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meno_design_system/meno_design_system.dart';
import 'package:meno_flutter/src/features/auth/auth.dart';
import 'package:meno_flutter/src/shared/domain/exceptions/value_exception.dart';

class PasswordRulesWidgetTracker extends StatelessWidget {
  const PasswordRulesWidgetTracker({super.key});
  @override
  Widget build(BuildContext context) {
    const errors = [
      PasswordTooShort(),
      PasswordMissingUppercase(),
      PasswordMissingLowercase(),
      PasswordMissingNumber(),
      PasswordMissingSpecialCharacter(),
    ];

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
  final ValueException<String> error;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = MenoColorScheme.of(context);

    final rules = ref.watch(
      registerFormProvider.select((s) => s.passwordRules),
    );

    final isCurrentError = rules?.contains(error) ?? false;

    final effectiveColor =
        rules == null
            ? colors.labelPlaceholder
            : isCurrentError
            ? colors.errorBase
            : colors.successBase;

    final title = error.title;
    final subtitle = error.subtitle;

    if (title == null || subtitle == null) return const SizedBox.shrink();

    return SizedBox(
      height: 38,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MenoText.subheading(title, color: effectiveColor),
          MenoText.nano(subtitle, color: effectiveColor),
        ],
      ),
    );
  }
}
