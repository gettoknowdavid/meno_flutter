import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meno_flutter/features/auth/auth.dart';
import 'package:meno_flutter/shared/shared.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_facade.g.dart';

@riverpod
Stream<UserCredential?> authStateChanges(Ref ref) {
  return ref.watch(authFacadeProvider.notifier).authStateChanges;
}

@riverpod
class AuthFacade extends _$AuthFacade implements IAuthFacade {
  final _controller = StreamController<UserCredential?>.broadcast();

  @override
  FutureOr<UserCredential?> build() async {
    ref.onDispose(_controller.close);

    final dto = await ref.watch(authLocalProvider).getCurrentAccount();
    final credential = dto?.toDomain;
    _controller.add(credential);
    return credential;
  }

  @override
  Future<void> login({
    required EmailAddress email,
    required Password password,
  }) async {
    state = const AsyncLoading();
    final result = await ref
        .read(authRemoteProvider)
        .login(email: email.value, password: password.value);
    state = result.fold(
      (exception) => AsyncError(exception, StackTrace.current),
      (response) {
        final credential = response.data;
        if (credential != null) {
          _controller.add(credential.toDomain);
          ref.read(authLocalProvider).addAccount(credential);
          return AsyncData(credential.toDomain);
        }
        return AsyncError(const NoCredentialsException(), StackTrace.current);
      },
    );
  }

  @override
  Future<void> register({
    required FullName fullName,
    required EmailAddress email,
    required Password password,
    Bio? bio,
  }) async {
    state = const AsyncLoading();
    final result = await ref
        .read(authRemoteProvider)
        .register(
          fullName: fullName.value,
          email: email.value,
          password: password.value,
        );
    state = result.fold(
      (exception) => AsyncError(exception, StackTrace.current),
      (response) {
        final credential = response.data;
        if (credential != null) {
          _controller.add(credential.toDomain);
          ref.read(authLocalProvider).addAccount(credential);
          return AsyncData(credential.toDomain);
        }

        return AsyncError(const NoCredentialsException(), StackTrace.current);
      },
    );
  }

  @override
  Future<void> switchAccount(Id id) {
    // TODO: implement switchAccount
    throw UnimplementedError();
  }

  @override
  Future<void> logout() {
    _controller.add(null);
    return ref.read(authLocalProvider).removeAccount();
  }

  @override
  Stream<UserCredential?> get authStateChanges => _controller.stream;
}
