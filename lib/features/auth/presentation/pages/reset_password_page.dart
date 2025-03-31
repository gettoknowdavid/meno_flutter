import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:meno_design_system/meno_design_system.dart';
import 'package:meno_flutter/features/auth/auth.dart';

class ResetPasswordPage extends HookWidget {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = MenoTextTheme.of(context);
    final otpReceived = useState(false);
    return Scaffold(
      appBar: MenoTopBar.primary(title: 'Reset password'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: Insets.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const MenoSpacer.v(24),
            if (otpReceived.value) ...[
              const _ResetPasswordInfo(),
              const MenoSpacer.v(Insets.lg),
              const ResetPasswordFormWidget(),
            ] else ...[
              const MenoText.heading2('OTP verification'),
              const MenoSpacer.v(Insets.xs),
              Text.rich(
                TextSpan(
                  style: textTheme.captionRegular,
                  children: [
                    const TextSpan(
                      text: 'Enter the 4-digit code we just sent to ',
                    ),
                    TextSpan(
                      text: 'thenewbirthgroup@gmail.com',
                      style: textTheme.captionBold,
                    ),
                    const TextSpan(text: ' to continue'),
                  ],
                ),
              ),
              const MenoSpacer.v(Insets.xxlg),
              const MenoOtpField(),
              const MenoSpacer.v(24),
              const ResendTextWithTimerWidget(),
              const MenoSpacer.v(Insets.xxlg),
              MenoPrimaryButton(
                size: MenoSize.lg,
                onPressed: () {},
                child: const Text('Continue'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _ResetPasswordInfo extends StatelessWidget {
  const _ResetPasswordInfo();

  @override
  Widget build(BuildContext context) {
    final colors = MenoColorScheme.of(context);
    return Container(
      padding: const EdgeInsets.all(Insets.md),
      decoration: BoxDecoration(
        borderRadius: MenoBorderRadius.sm,
        color: colors.componentPrimary,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(MIcons.info_circle, size: 14),
          const MenoSpacer.h(Insets.sm),
          Expanded(
            child: MenoText.micro(
              '''
Please enter the email associated with your account and we will send an email with instructions to reset your password.''',
              weight: MenoFontWeight.regular,
              color: colors.labelHelp,
            ),
          ),
        ],
      ),
    );
  }
}
