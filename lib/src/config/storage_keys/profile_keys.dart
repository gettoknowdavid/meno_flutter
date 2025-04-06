import 'package:meno_flutter/src/features/profile/profile.dart' show Profile;
import 'package:meno_flutter/src/services/services.dart';

final class ProfileKeys {
  const ProfileKeys._();

  /// Stores the [Profile] of the currently authenticted user in
  /// [SecureStorageService]
  ///
  static const String myProfile = '_my_profile_';
}
