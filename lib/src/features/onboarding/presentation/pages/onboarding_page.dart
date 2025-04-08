import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:meno_design_system/meno_design_system.dart';
import 'package:meno_flutter/src/features/auth/auth.dart' show RegisterWebView;
import 'package:meno_flutter/src/features/onboarding/onboarding.dart';
import 'package:meno_flutter/src/routing/routing.dart';
import 'package:responsive_framework/responsive_framework.dart';

class OnboardingPage extends HookWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isWeb = ResponsiveBreakpoints.of(context).largerThan(TABLET);
    return Scaffold(
      body: switch (isWeb) {
        true => const OnboardingWebView(),
        false => const OnboardingMobileView(),
      },
    );
  }
}

class OnboardingMobileView extends StatelessWidget {
  const OnboardingMobileView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(16, 24, 16, 30),
        child: OnboardingContent(),
      ),
    );
  }
}

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
                child: SizedBox(width: 461, child: RegisterWebView()),
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

class OnboardingContent extends StatelessWidget {
  const OnboardingContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const MenoLogo(),
        ResponsiveValue<Widget>(
          context,
          conditionalValues: [
            const Condition.largerThan(name: TABLET, value: MenoSpacer.v(112)),
            const Condition.smallerThan(name: TABLET, value: MenoSpacer.v(72)),
          ],
          defaultValue: const MenoSpacer.v(72),
        ).value,
        const LimitedBox(
          maxHeight: 460,
          maxWidth: 343,
          child: OnboardingBody(),
        ),
        ...ResponsiveValue<List<Widget>>(
          context,
          conditionalValues: [
            const Condition.largerThan(name: TABLET, value: []),
          ],
          defaultValue: [
            const MenoSpacer.v(24),
            MenoPrimaryButton(
              onPressed: () => const RegisterRoute().push<void>(context),
              size: MenoSize.lg,
              child: const Text('Get started'),
            ),
            const MenoSpacer.v(16),
            MenoSecondaryButton(
              onPressed: () => const LoginRoute().push<void>(context),
              size: MenoSize.lg,
              child: const Text('Login'),
            ),
          ],
        ).value,
      ],
    );
  }
}
