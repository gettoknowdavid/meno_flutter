import 'package:meno_flutter/features/auth/auth.dart';
import 'package:meno_flutter/services/services.dart';
import 'package:meno_flutter/shared/shared.dart';

final class AuthStorageKeys {
  const AuthStorageKeys._();

  /// Returns all the accounts stored in [SecureStorageService]
  static const String accounts = '_accounts_';

  /// Returns the currently active account stored in [SecureStorageService]
  static const String currentAccount = '_current_account_';

  /// Returns the [Id] of the currently authenticated [User]
  static const String authUserId = '_auth_user_id_';
}
