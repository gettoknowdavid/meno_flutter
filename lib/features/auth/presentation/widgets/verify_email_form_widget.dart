import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meno_design_system/meno_design_system.dart';
import 'package:meno_flutter/features/auth/presentation/widgets/resend_text_with_timer_widget.dart';

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
            const ResendTextWithTimerWidget(),
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
