import 'package:dartz/dartz.dart';
import 'package:meno_flutter/src/features/auth/auth.dart';
import 'package:meno_flutter/src/shared/shared.dart';

abstract class IAuthFacade {
  /// Returns all the [UserCredential]s of stored in the app secure storage.
  Stream<Map<String, UserCredential>> get allAccounts;

  /// Returns the [UserCredential] of the currently signed-in account (if any)
  Stream<UserCredential?> get authStateChanges;

  /// Logs the user in with their email address and password.
  ///
  /// Returns an `Either` value, where the left value is a `AuthException`
  /// object and the right value is a `Unit` object.
  Future<Either<AuthException, Unit>> login({
    required Email email,
    required Password password,
  });

  /// Registers a new user with Meno.
  ///
  /// Returns an `Either` value, where the left value is a `AuthException`
  /// object and the right value is a `Unit` object.
  Future<Either<AuthException, Unit>> register({
    required FullName fullName,
    required Email email,
    required Password password,
    Bio? bio,
  });

  Future<void> logout();

  // /// Logs the user out.
  // Future<void> logout();

  /// Switches to a different stored account. Returns an Either with success
  /// [UserCredential] or failure [AuthException] if the account isn't found or
  /// there's an issue.
  Future<Either<AuthException, Unit>> switchAccount(UserCredential credential);
}
