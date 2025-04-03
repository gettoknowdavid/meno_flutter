import 'package:flutter/material.dart';
import 'package:meno_design_system/meno_design_system.dart';
import 'package:meno_flutter/src/features/auth/auth.dart';

class NewPasswordFormWidget extends StatelessWidget {
  const NewPasswordFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = MenoColorScheme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        MenoTextfield(
          key: const Key('create_new_password_password_input'),
          placeholder: 'Must be at least 8 characters',
          label: 'New password',
          isPassword: true,
          prefixIcon: MIcons.key,
          size: MenoSize.lg,
          required: false,
        ),
        const MenoSpacer.v(Insets.sm),
        const PasswordRulesWidgetTracker(),
        const MenoSpacer.v(24),
        MenoTextfield(
          key: const Key('create_new_password__confirm_password_input'),
          placeholder: 'Must be at least 8 characters',
          label: 'Confirm new password',
          isPassword: true,
          prefixIcon: MIcons.key,
          size: MenoSize.lg,
          required: false,
        ),
        const MenoSpacer.v(8),
        MenoText.caption(
          'Both passwords must match',
          weight: MenoFontWeight.regular,
          color: colors.labelDisabled,
        ),
        const MenoSpacer.v(Insets.xxlg),
        MenoPrimaryButton(
          size: MenoSize.lg,
          onPressed: () {},
          child: const Text('Reset password'),
        ),
      ],
    );
  }
}
