import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meno_flutter/features/auth/domain/domain.dart';
import 'package:meno_flutter/features/settings/settings.dart';
import 'package:meno_flutter/shared/shared.dart';

part 'user.freezed.dart';

@freezed
abstract class User with _$User {
  const factory User({
    required Id id,
    required SingleLineString fullName,
    required EmailAddress email,
    GeneralSettings? generalSettings,
    Bio? bio,
    AuthRole? role,
    String? imageId,
    String? imageUrl,
    @Default(false) bool verified,
    String? emailAccountType,
  }) = _User;
}

extension UserX on User {
  User get stripped {
    return User(id: id, fullName: fullName, email: email, imageUrl: imageUrl);
  }
}
