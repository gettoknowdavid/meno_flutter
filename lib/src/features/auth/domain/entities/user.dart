import 'package:equatable/equatable.dart';
import 'package:meno_flutter/src/features/auth/domain/domain.dart';
import 'package:meno_flutter/src/features/settings/settings.dart';
import 'package:meno_flutter/src/shared/shared.dart';

final class User with EquatableMixin {
  const User({
    required this.id,
    required this.fullName,
    required this.email,
    this.bio,
    this.generalSettings,
    this.role,
    this.imageId,
    this.imageUrl,
    this.verified = false,
    this.emailAccountType,
  });

  final Id id;
  final FullName fullName;
  final Email email;
  final Bio? bio;
  final GeneralSettings? generalSettings;
  final AuthRole? role;
  final String? imageId;
  final String? imageUrl;
  final bool verified;
  final String? emailAccountType;

  User copyWith({
    Id? id,
    FullName? fullName,
    Email? email,
    Bio? bio,
    GeneralSettings? generalSettings,
    AuthRole? role,
    String? imageId,
    String? imageUrl,
    bool? verified,
    String? emailAccountType,
  }) {
    return User(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      bio: bio ?? this.bio,
      generalSettings: generalSettings ?? this.generalSettings,
      role: role ?? this.role,
      imageId: imageId ?? this.imageId,
      imageUrl: imageUrl ?? this.imageUrl,
      verified: verified ?? this.verified,
      emailAccountType: emailAccountType ?? this.emailAccountType,
    );
  }

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

extension UserX on User {
  User get stripped {
    return User(id: id, fullName: fullName, email: email, imageUrl: imageUrl);
  }
}
