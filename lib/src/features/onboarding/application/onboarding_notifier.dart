import 'package:meno_flutter/src/features/onboarding/data/onboarding_facade.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'onboarding_notifier.g.dart';

@riverpod
class OnboardingNotifier extends _$OnboardingNotifier {
  @override
  bool build() => ref.watch(onboardingFacadeProvider).onboardingComplete;

  Future<void> complete() async {
    final facade = ref.read(onboardingFacadeProvider);
    final result = await facade.completeOnboarding();
    state = result;
  }
}
