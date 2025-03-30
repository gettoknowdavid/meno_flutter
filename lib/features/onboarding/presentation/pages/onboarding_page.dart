import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:meno_flutter/features/onboarding/onboarding.dart';
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
