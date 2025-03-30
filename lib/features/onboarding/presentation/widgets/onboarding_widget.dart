import 'package:flutter/material.dart';
import 'package:meno_design_system/meno_design_system.dart';
import 'package:meno_flutter/features/onboarding/domain/onboarding.dart';
import 'package:meno_flutter/features/onboarding/presentation/widgets/widgets.dart';

class OnboardingWidget extends StatelessWidget {
  const OnboardingWidget({required this.onboarding, super.key});
  final Onboarding onboarding;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox.square(
          dimension: 240,
          child: Image.asset(onboarding.imagePath),
        ),
        const MenoSpacer.v(24),
        OnboardingTitle(title: onboarding.title),
        const MenoSpacer.v(16),
        OnboardingDescription(desc: onboarding.desc),
      ],
    );
  }
}
