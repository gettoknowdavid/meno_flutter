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
      email: email.getOrCrash(),
      password: password.getOrCrash(),
    );

    return response.fold(Left.new, (response) async {
      await _local.addAccount(response.data!);
      return right(unit);
    });
  }

  @override
  Future<Either<AuthException, Unit>> register({
    required SingleLineString fullName,
    required Email email,
    required Password password,
  }) async {
    final response = await _remote.register(
      fullName: fullName.getOrCrash(),
      email: email.getOrCrash(),
      password: password.getOrCrash(),
    );

    return response.fold(Left.new, (response) async {
      await _local.addAccount(response.data!);
      return right(unit);
    });
  }

  @override
  Future<Either<AuthException, Unit>> switchAccount(
    UserCredential credential,
  ) async {
    final credentialDto = credential.toDto;
    try {
      await _local.switchAccount(credentialDto);
      return right(unit);
    } on Exception catch (e) {
      return left(AuthExceptionWithMessage(e.toString()));
    }
  }

  @override
  Future<void> logout() => _local.logout();

  @override
  Stream<UserCredential?> get authStateChanges {
    return _local.authStateChanges.map((e) => e?.toDomain);
  }

  @override
  Stream<Map<String, UserCredential>> get allAccounts {
    return _local.allAccountsStream.map((dtoMap) {
      final domainMap = <String, UserCredential>{};
      dtoMap.forEach((key, dto) => domainMap[key] = dto.toDomain);
      return domainMap;
    });
  }
}
