import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meno_flutter/features/auth/auth.dart';
import 'package:meno_flutter/features/settings/settings.dart';
import 'package:meno_flutter/shared/shared.dart';

part 'user_dto.freezed.dart';
part 'user_dto.g.dart';

@freezed
abstract class UserDto with _$UserDto {
  const factory UserDto({
    required String id,
    required String fullName,
    required String email,
    GeneralSettingsDto? generalSettings,
    String? bio,
    AuthRole? role,
    String? imageId,
    String? imageUrl,
    @Default(false) bool verified,
    String? emailAccountType,
  }) = _UserDto;

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);
}

extension UserDtoX on UserDto {
  UserDto get stripped {
    return UserDto(
      id: id,
      fullName: fullName,
      email: email,
      imageUrl: imageUrl,
    );
  }

  User get toDomain {
    return User(
      id: Id.fromString(id),
      email: EmailAddress.pure(email),
      fullName: SingleLineString.pure(fullName),
      bio: bio == null ? null : Bio.pure(bio),
      generalSettings: generalSettings?.toDomain,
      role: role,
      emailAccountType: emailAccountType,
      imageId: imageId,
      imageUrl: imageUrl,
      verified: verified,
    );
  }
}

extension UserToDomainX on User {
  UserDto get toDto {
    return UserDto(
      id: id.getOrElse(''),
      email: email.value,
      fullName: fullName.value,
      bio: bio?.value,
      generalSettings: generalSettings?.toDto,
      role: role,
      emailAccountType: emailAccountType,
      imageId: imageId,
      imageUrl: imageUrl,
      verified: verified,
    );
  }
}
