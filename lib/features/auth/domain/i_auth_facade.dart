import 'package:meno_flutter/features/auth/auth.dart';
import 'package:meno_flutter/shared/shared.dart';

abstract class IAuthFacade {
  // /// Returns the identifier - [Id] of the currently signed-in account (if any)
  // Id? get currentUserId;

  // /// Returns the [User] object of the currently signed-in account (if any)
  // User? get currentUser;

  /// Returns the [UserCredential] of the currently signed-in account (if any)
  Stream<UserCredential?> get authStateChanges;

  /// Logs the user in with their email address and password.
  ///
  /// Returns an `Either` value, where the left value is a `AuthException`
  /// object and the right value is a `Unit` object.
  Future<void> login({required EmailAddress email, required Password password});

  /// Registers a new user with Meno.
  ///
  /// Returns an `Either` value, where the left value is a `AuthException`
  /// object and the right value is a `Unit` object.
  Future<void> register({
    required FullName fullName,
    required EmailAddress email,
    required Password password,
    Bio? bio,
  });

  Future<void> logout();

  // /// Logs the user out.
  // Future<void> logout();

  /// Switches to a different stored account. Returns an Either with success
  /// [UserCredential] or failure [AuthException] if the account isn't found or
  /// there's an issue.
  Future<void> switchAccount(Id id);
}
