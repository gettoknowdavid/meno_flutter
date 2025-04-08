import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meno_flutter/src/features/onboarding/onboarding.dart';
import 'package:meno_flutter/src/services/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'onboarding_facade.g.dart';

@riverpod
IOnboardingFacade onboardingFacade(Ref ref) {
  final storage = ref.read(sharedPrefsProvider);
  final local = OnboardingLocalDatasource(storage: storage);
  return OnboardingFacade(local: local);
}

class OnboardingFacade implements IOnboardingFacade {
  const OnboardingFacade({required OnboardingLocalDatasource local})
    : _local = local;
  final OnboardingLocalDatasource _local;

  @override
  Future<bool> completeOnboarding() => _local.completeOnboarding();

  @override
  bool get onboardingComplete => _local.onboardingComplete;
}
