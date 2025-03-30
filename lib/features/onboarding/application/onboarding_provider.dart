import 'package:meno_flutter/features/onboarding/data/onboarding_facade.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'onboarding_provider.g.dart';

@riverpod
class Onboarding extends _$Onboarding {
  @override
  FutureOr<bool> build() {
    return ref.read(onboardingFacadeProvider).onboardingComplete;
  }

  Future<void> completeOnboarding() async {
    return ref.read(onboardingFacadeProvider).completeOnboarding();
  }
}
