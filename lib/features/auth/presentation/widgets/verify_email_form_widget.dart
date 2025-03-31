import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meno_design_system/meno_design_system.dart';

class VerifyEmailFormWidget extends HookConsumerWidget {
  const VerifyEmailFormWidget({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = MenoTextTheme.of(context);
    return Scaffold(
      appBar: MenoTopBar.primary(
        title: 'Verify your email',
        implyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: Insets.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const MenoSpacer.v(24),
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
            const _ResendTextWithTimer(),
            const MenoSpacer.v(Insets.xxlg),
            MenoPrimaryButton(
              size: MenoSize.lg,
              onPressed: () {},
              child: const Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }
}

class _ResendTextWithTimer extends StatelessWidget {
  const _ResendTextWithTimer();

  @override
  Widget build(BuildContext context) {
    final textTheme = MenoTextTheme.of(context);
    final colors = MenoColorScheme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text.rich(
          TextSpan(
            style: textTheme.captionMedium.copyWith(
              color: colors.labelPlaceholder,
            ),
            children: [
              // const TextSpan(text: 'Didn\'t receive code? '),
              const TextSpan(text: 'Resend code in '),
              TextSpan(text: ' 00:59', style: textTheme.captionBold),
            ],
          ),
          textAlign: TextAlign.center,
        ),
        const MenoSpacer.h(4),
        // SizedBox(
        //   height: 18,
        //   child: MenoTertiaryButton(
        //     onPressed: () {},
        //     style: ButtonStyle(padding: Internal.all(EdgeInsets.zero)),
        //     child: const MenoText.caption('Resend'),
        //   ),
        // ),
      ],
    );
  }
}
