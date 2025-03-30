import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meno_flutter/config/storage_keys/onboarding_storage_keys.dart';
import 'package:meno_flutter/services/secure_storage_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'onboarding_local_datasource.g.dart';

@riverpod
OnboardingLocalDatasource onboardingLocalDatasource(Ref ref) {
  final storage = ref.read(secureStorageProvider);
  return OnboardingLocalDatasourceImpl(storage: storage);
}

abstract class OnboardingLocalDatasource {
  Future<bool> get onboardingComplete;

  Future<void> completeOnboarding();
}

class OnboardingLocalDatasourceImpl implements OnboardingLocalDatasource {
  const OnboardingLocalDatasourceImpl({required SecureStorageService storage})
    : _storage = storage;
  final SecureStorageService _storage;

  @override
  Future<void> completeOnboarding() {
    return _storage.write(OnboardingStorageKeys.onboarding, value: '1');
  }

  @override
  Future<bool> get onboardingComplete {
    return _storage.hasKey(OnboardingStorageKeys.onboarding);
  }
}
