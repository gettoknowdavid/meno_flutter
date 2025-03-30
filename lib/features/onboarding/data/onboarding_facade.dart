import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meno_flutter/features/onboarding/onboarding.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'onboarding_facade.g.dart';

@riverpod
IOnboardingFacade onboardingFacade(Ref ref) {
  final local = ref.read(onboardingLocalDatasourceProvider);
  return OnboardingFacade(local: local);
}

class OnboardingFacade implements IOnboardingFacade {
  const OnboardingFacade({required OnboardingLocalDatasource local})
    : _local = local;
  final OnboardingLocalDatasource _local;

  @override
  Future<void> completeOnboarding() => _local.completeOnboarding();

  @override
  Future<bool> get onboardingComplete => _local.onboardingComplete;
}
