import 'package:meno_flutter/src/config/config.dart';
import 'package:meno_flutter/src/features/auth/auth.dart';
import 'package:meno_flutter/src/services/services.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_providers.g.dart';

@riverpod
IAuthFacade authFacade(Ref ref) {
  final baseUrl = ref.read(menoUrlProvider);
  final dio = ref.read(dioProvider(baseUrl));

  final storage = ref.read(secureStorageProvider);

  final remote = AuthRemoteDatasource(dio, baseUrl: baseUrl);
  final local = AuthLocalDatasource(storage: storage);

  ref.onDispose(local.dispose);

  return AuthFacade(remote: remote, local: local);
}

@riverpod
Stream<UserCredential?> authStateChanges(Ref ref) {
  return ref.watch(authFacadeProvider).authStateChanges;
}
