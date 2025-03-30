import 'package:flutter/material.dart';
import 'package:meno_design_system/meno_design_system.dart';
import 'package:meno_flutter/features/auth/auth.dart';
import 'package:meno_flutter/features/onboarding/onboarding.dart';

class OnboardingWebView extends StatelessWidget {
  const OnboardingWebView({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = MenoColorScheme.of(context);
    return Padding(
      padding: const EdgeInsets.all(Insets.lg),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Expanded(
            child: SingleChildScrollView(
              child: Center(
                child: SizedBox(
                  width: 461,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      MenoText.heading1('Create new account'),
                      MenoSpacer.v(Insets.xs),
                      MenoText.subheading(
                        'Begin your meno streaming and broadcasting experience.',
                        weight: MenoFontWeight.regular,
                      ),
                      MenoSpacer.v(32),
                      CreateAccountForm(),
                      MenoSpacer.v(32),
                      AuthOrDivider(),
                      MenoSpacer.v(24),
                      GoogleButton(),
                      MenoSpacer.v(56),
                      AuthRedirectionPrompt(),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Flexible(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 693),
              padding: const EdgeInsets.fromLTRB(175, 112, 175, 0),
              decoration: BoxDecoration(
                color: colors.brandPrimaryLighter,
                borderRadius: MenoBorderRadius.xxlg,
              ),
              child: const OnboardingContent(),
            ),
          ),
        ],
      ),
    );
  }
}
