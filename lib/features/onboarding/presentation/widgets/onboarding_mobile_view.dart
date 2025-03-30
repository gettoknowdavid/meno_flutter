import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:meno_design_system/meno_design_system.dart';
import 'package:meno_flutter/features/onboarding/presentation/widgets/meno_logo.dart';
import 'package:meno_flutter/features/onboarding/presentation/widgets/onboarding_body.dart';
import 'package:meno_flutter/routing/routing.dart';
import 'package:responsive_framework/responsive_framework.dart';

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
              onPressed: () => context.push(Routes.register.path),
              size: MenoSize.lg,
              child: const Text('Get started'),
            ),
            const MenoSpacer.v(16),
            MenoSecondaryButton(
              onPressed: () => context.push(Routes.login.path),
              size: MenoSize.lg,
              child: const Text('Login'),
            ),
          ],
        ).value,
      ],
    );
  }
}
