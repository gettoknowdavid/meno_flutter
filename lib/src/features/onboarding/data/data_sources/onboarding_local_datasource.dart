import 'package:meno_flutter/src/config/storage_keys/onboarding_storage_keys.dart';
import 'package:meno_flutter/src/services/services.dart';

class OnboardingLocalDatasource {
  const OnboardingLocalDatasource({required SharedPreferencesService storage})
    : _storage = storage;
  final SharedPreferencesService _storage;

  Future<void> completeOnboarding() {
    return _storage.write(OnboardingStorageKeys.onboarding, value: '1');
  }

  bool get onboardingComplete {
    return _storage.hasKey(OnboardingStorageKeys.onboarding);
  }
}
