import 'package:meno_flutter/features/auth/auth.dart';
import 'package:meno_flutter/shared/shared.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_facade.g.dart';

@riverpod
class AuthFacade extends _$AuthFacade implements IAuthFacade {
  @override
  FutureOr<UserCredential?> build() async {
    final credential = await ref.watch(authLocalProvider).getCurrentAccount();
    return credential?.toDomain;
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
      (response) => AsyncData(response.data?.toDomain),
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
      (response) => AsyncData(response.data?.toDomain),
    );
  }

  @override
  Future<void> switchAccount(Id id) {
    // TODO: implement switchAccount
    throw UnimplementedError();
  }
}
