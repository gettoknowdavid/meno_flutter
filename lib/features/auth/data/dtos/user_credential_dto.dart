import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meno_flutter/features/auth/auth.dart';

part 'user_credential_dto.freezed.dart';
part 'user_credential_dto.g.dart';

@freezed
abstract class UserCredentialDto with _$UserCredentialDto {
  const factory UserCredentialDto({required UserDto user, String? token}) =
      _UserCredentialDto;

  factory UserCredentialDto.fromJson(Map<String, dynamic> json) =>
      _$UserCredentialDtoFromJson(json);
}

extension UserCrendentialDtoX on UserCredentialDto {
  UserCredentialDto get stripped {
    return UserCredentialDto(user: user.stripped, token: token);
  }

  UserCredential get toDomain {
    return UserCredential(
      user: user.toDomain,
      token: token != null ? Token(token!) : null,
    );
  }
}

extension UserCredentialToDtoX on UserCredential {
  UserCredentialDto get toDto {
    return UserCredentialDto(user: user.toDto, token: token?.getOrNull());
  }
}
