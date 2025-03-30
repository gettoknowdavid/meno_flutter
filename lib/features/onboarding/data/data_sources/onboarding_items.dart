import 'package:meno_design_system/meno_design_system.dart';
import 'package:meno_flutter/features/onboarding/domain/onboarding.dart';

final List<Onboarding> onboardingItems = <Onboarding>[
  Onboarding(
    title: 'Broadcast',
    desc: 'to your audience and share links for them to join your broadcast.',
    imagePath: MenoAssets.images.onboarding.onboarding1.keyName,
  ),
  Onboarding(
    title: 'Stream',
    desc: 'broadcasts from individuals or ministries you are interested in.',
    imagePath: MenoAssets.images.onboarding.onboarding2.keyName,
  ),
  Onboarding(
    title: 'Live Bible',
    desc: 'as you stream, have an immersive experience.',
    imagePath: MenoAssets.images.onboarding.onboarding3.keyName,
  ),
  Onboarding(
    title: 'Take Notes',
    desc: 'as you stream, take note of things that stand out to you.',
    imagePath: MenoAssets.images.onboarding.onboarding4.keyName,
  ),
];
