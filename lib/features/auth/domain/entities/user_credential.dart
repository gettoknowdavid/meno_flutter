import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meno_flutter/features/auth/domain/domain.dart';

part 'user_credential.freezed.dart';

@freezed
abstract class UserCredential with _$UserCredential {
  const factory UserCredential({
    /// The user.
    required User user,

    /// The user's token.
    Token? token,
  }) = _UserCredential;
}

extension UserCrendentialX on UserCredential {
  UserCredential get stripped {
    return UserCredential(user: user.stripped, token: token);
  }
}
