import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meno_flutter/src/features/auth/auth.dart';
import 'package:meno_flutter/src/features/settings/settings.dart';
import 'package:meno_flutter/src/shared/shared.dart';

part 'user_dto.g.dart';

@JsonSerializable()
final class UserDto with EquatableMixin {
  const UserDto({
    required this.id,
    required this.fullName,
    required this.email,
    this.generalSettings,
    this.bio,
    this.role,
    this.imageId,
    this.imageUrl,
    this.verified = false,
    this.emailAccountType,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UserDtoToJson(this);

  final String id;
  final String fullName;
  final String email;
  final String? bio;
  final GeneralSettingsDto? generalSettings;
  final AuthRole? role;
  final String? imageId;
  final String? imageUrl;
  final bool verified;
  final String? emailAccountType;

  @override
  List<Object?> get props => [
    id,
    fullName,
    email,
    bio,
    generalSettings,
    role,
    imageId,
    imageUrl,
    verified,
    emailAccountType,
  ];

  @override
  bool get stringify => true;
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
      email: Email.pure(email),
      fullName: FullName.pure(fullName),
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
