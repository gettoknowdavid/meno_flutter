import 'package:meno_flutter/src/features/auth/auth.dart';
import 'package:meno_flutter/src/services/services.dart';
import 'package:meno_flutter/src/shared/shared.dart';

final class AuthStorageKeys {
  const AuthStorageKeys._();

  /// Returns all the accounts stored in [SecureStorageService]
  static const String allAccounts = '_accounts_';

  /// Returns the [Id] of the currently authenticated [User]
  static const String currentUserId = '_auth_user_id_';

  /// Returns the [Token] of the currently authenticated [User]
  static const String currentUserToken = '_auth_user_token_';

  /// Key for storing user data for the 'Remember me' feature.
  static const String rememberedUser = '_remembered_user_';
}
