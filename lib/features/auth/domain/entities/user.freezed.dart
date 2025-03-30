// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$User {

 Id get id; SingleLineString get fullName; EmailAddress get email; GeneralSettings? get generalSettings; Bio? get bio; AuthRole? get role; String? get imageId; String? get imageUrl; bool get verified; String? get emailAccountType;
/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserCopyWith<User> get copyWith => _$UserCopyWithImpl<User>(this as User, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is User&&(identical(other.id, id) || other.id == id)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.email, email) || other.email == email)&&(identical(other.generalSettings, generalSettings) || other.generalSettings == generalSettings)&&(identical(other.bio, bio) || other.bio == bio)&&(identical(other.role, role) || other.role == role)&&(identical(other.imageId, imageId) || other.imageId == imageId)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.verified, verified) || other.verified == verified)&&(identical(other.emailAccountType, emailAccountType) || other.emailAccountType == emailAccountType));
}


@override
int get hashCode => Object.hash(runtimeType,id,fullName,email,generalSettings,bio,role,imageId,imageUrl,verified,emailAccountType);

@override
String toString() {
  return 'User(id: $id, fullName: $fullName, email: $email, generalSettings: $generalSettings, bio: $bio, role: $role, imageId: $imageId, imageUrl: $imageUrl, verified: $verified, emailAccountType: $emailAccountType)';
}


}

/// @nodoc
abstract mixin class $UserCopyWith<$Res>  {
  factory $UserCopyWith(User value, $Res Function(User) _then) = _$UserCopyWithImpl;
@useResult
$Res call({
 Id id, SingleLineString fullName, EmailAddress email, GeneralSettings? generalSettings, Bio? bio, AuthRole? role, String? imageId, String? imageUrl, bool verified, String? emailAccountType
});


$GeneralSettingsCopyWith<$Res>? get generalSettings;

}
/// @nodoc
class _$UserCopyWithImpl<$Res>
    implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._self, this._then);

  final User _self;
  final $Res Function(User) _then;

/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? fullName = null,Object? email = null,Object? generalSettings = freezed,Object? bio = freezed,Object? role = freezed,Object? imageId = freezed,Object? imageUrl = freezed,Object? verified = null,Object? emailAccountType = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as Id,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as SingleLineString,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as EmailAddress,generalSettings: freezed == generalSettings ? _self.generalSettings : generalSettings // ignore: cast_nullable_to_non_nullable
as GeneralSettings?,bio: freezed == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as Bio?,role: freezed == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as AuthRole?,imageId: freezed == imageId ? _self.imageId : imageId // ignore: cast_nullable_to_non_nullable
as String?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,verified: null == verified ? _self.verified : verified // ignore: cast_nullable_to_non_nullable
as bool,emailAccountType: freezed == emailAccountType ? _self.emailAccountType : emailAccountType // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GeneralSettingsCopyWith<$Res>? get generalSettings {
    if (_self.generalSettings == null) {
    return null;
  }

  return $GeneralSettingsCopyWith<$Res>(_self.generalSettings!, (value) {
    return _then(_self.copyWith(generalSettings: value));
  });
}
}


/// @nodoc


class _User implements User {
  const _User({required this.id, required this.fullName, required this.email, this.generalSettings, this.bio, this.role, this.imageId, this.imageUrl, this.verified = false, this.emailAccountType});
  

@override final  Id id;
@override final  SingleLineString fullName;
@override final  EmailAddress email;
@override final  GeneralSettings? generalSettings;
@override final  Bio? bio;
@override final  AuthRole? role;
@override final  String? imageId;
@override final  String? imageUrl;
@override@JsonKey() final  bool verified;
@override final  String? emailAccountType;

/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserCopyWith<_User> get copyWith => __$UserCopyWithImpl<_User>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _User&&(identical(other.id, id) || other.id == id)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.email, email) || other.email == email)&&(identical(other.generalSettings, generalSettings) || other.generalSettings == generalSettings)&&(identical(other.bio, bio) || other.bio == bio)&&(identical(other.role, role) || other.role == role)&&(identical(other.imageId, imageId) || other.imageId == imageId)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.verified, verified) || other.verified == verified)&&(identical(other.emailAccountType, emailAccountType) || other.emailAccountType == emailAccountType));
}


@override
int get hashCode => Object.hash(runtimeType,id,fullName,email,generalSettings,bio,role,imageId,imageUrl,verified,emailAccountType);

@override
String toString() {
  return 'User(id: $id, fullName: $fullName, email: $email, generalSettings: $generalSettings, bio: $bio, role: $role, imageId: $imageId, imageUrl: $imageUrl, verified: $verified, emailAccountType: $emailAccountType)';
}


}

/// @nodoc
abstract mixin class _$UserCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$UserCopyWith(_User value, $Res Function(_User) _then) = __$UserCopyWithImpl;
@override @useResult
$Res call({
 Id id, SingleLineString fullName, EmailAddress email, GeneralSettings? generalSettings, Bio? bio, AuthRole? role, String? imageId, String? imageUrl, bool verified, String? emailAccountType
});


@override $GeneralSettingsCopyWith<$Res>? get generalSettings;

}
/// @nodoc
class __$UserCopyWithImpl<$Res>
    implements _$UserCopyWith<$Res> {
  __$UserCopyWithImpl(this._self, this._then);

  final _User _self;
  final $Res Function(_User) _then;

/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? fullName = null,Object? email = null,Object? generalSettings = freezed,Object? bio = freezed,Object? role = freezed,Object? imageId = freezed,Object? imageUrl = freezed,Object? verified = null,Object? emailAccountType = freezed,}) {
  return _then(_User(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as Id,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as SingleLineString,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as EmailAddress,generalSettings: freezed == generalSettings ? _self.generalSettings : generalSettings // ignore: cast_nullable_to_non_nullable
as GeneralSettings?,bio: freezed == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as Bio?,role: freezed == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as AuthRole?,imageId: freezed == imageId ? _self.imageId : imageId // ignore: cast_nullable_to_non_nullable
as String?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,verified: null == verified ? _self.verified : verified // ignore: cast_nullable_to_non_nullable
as bool,emailAccountType: freezed == emailAccountType ? _self.emailAccountType : emailAccountType // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GeneralSettingsCopyWith<$Res>? get generalSettings {
    if (_self.generalSettings == null) {
    return null;
  }

  return $GeneralSettingsCopyWith<$Res>(_self.generalSettings!, (value) {
    return _then(_self.copyWith(generalSettings: value));
  });
}
}

// dart format on
