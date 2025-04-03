import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:meno_flutter/src/features/auth/auth.dart';
import 'package:meno_flutter/src/shared/shared.dart';

class AuthFacade implements IAuthFacade {
  AuthFacade({
    required AuthRemoteDatasource remote,
    required AuthLocalDatasource local,
  }) : _remote = remote,
       _local = local;

  final AuthRemoteDatasource _remote;
  final AuthLocalDatasource _local;

  @override
  Future<Either<AuthException, Unit>> login({
    required Email email,
    required Password password,
  }) async {
    final response = await _remote.login(
      email: email.value,
      password: password.value,
    );

    return response.fold(Left.new, (response) {
      _local.addAccount(response.data!);
      return right(unit);
    });
  }

  @override
  Future<Either<AuthException, Unit>> register({
    required FullName fullName,
    required Email email,
    required Password password,
    Bio? bio,
  }) async {
    final response = await _remote.register(
      fullName: fullName.value,
      email: email.value,
      password: password.value,
    );

    return response.fold(Left.new, (response) {
      _local.addAccount(response.data!);
      return right(unit);
    });
  }

  @override
  Future<void> switchAccount(Id id) {
    // TODO: implement switchAccount
    throw UnimplementedError();
  }

  @override
  Future<void> logout() => _local.removeAccount();

  @override
  Stream<UserCredential?> get authStateChanges {
    return _local.authStateChanges.map((e) => e?.toDomain);
  }
}
