// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserDto {

 String get id; String get fullName; String get email; GeneralSettingsDto? get generalSettings; String? get bio; AuthRole? get role; String? get imageId; String? get imageUrl; bool get verified; String? get emailAccountType;
/// Create a copy of UserDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserDtoCopyWith<UserDto> get copyWith => _$UserDtoCopyWithImpl<UserDto>(this as UserDto, _$identity);

  /// Serializes this UserDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserDto&&(identical(other.id, id) || other.id == id)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.email, email) || other.email == email)&&(identical(other.generalSettings, generalSettings) || other.generalSettings == generalSettings)&&(identical(other.bio, bio) || other.bio == bio)&&(identical(other.role, role) || other.role == role)&&(identical(other.imageId, imageId) || other.imageId == imageId)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.verified, verified) || other.verified == verified)&&(identical(other.emailAccountType, emailAccountType) || other.emailAccountType == emailAccountType));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,fullName,email,generalSettings,bio,role,imageId,imageUrl,verified,emailAccountType);

@override
String toString() {
  return 'UserDto(id: $id, fullName: $fullName, email: $email, generalSettings: $generalSettings, bio: $bio, role: $role, imageId: $imageId, imageUrl: $imageUrl, verified: $verified, emailAccountType: $emailAccountType)';
}


}

/// @nodoc
abstract mixin class $UserDtoCopyWith<$Res>  {
  factory $UserDtoCopyWith(UserDto value, $Res Function(UserDto) _then) = _$UserDtoCopyWithImpl;
@useResult
$Res call({
 String id, String fullName, String email, GeneralSettingsDto? generalSettings, String? bio, AuthRole? role, String? imageId, String? imageUrl, bool verified, String? emailAccountType
});


$GeneralSettingsDtoCopyWith<$Res>? get generalSettings;

}
/// @nodoc
class _$UserDtoCopyWithImpl<$Res>
    implements $UserDtoCopyWith<$Res> {
  _$UserDtoCopyWithImpl(this._self, this._then);

  final UserDto _self;
  final $Res Function(UserDto) _then;

/// Create a copy of UserDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? fullName = null,Object? email = null,Object? generalSettings = freezed,Object? bio = freezed,Object? role = freezed,Object? imageId = freezed,Object? imageUrl = freezed,Object? verified = null,Object? emailAccountType = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,generalSettings: freezed == generalSettings ? _self.generalSettings : generalSettings // ignore: cast_nullable_to_non_nullable
as GeneralSettingsDto?,bio: freezed == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String?,role: freezed == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as AuthRole?,imageId: freezed == imageId ? _self.imageId : imageId // ignore: cast_nullable_to_non_nullable
as String?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,verified: null == verified ? _self.verified : verified // ignore: cast_nullable_to_non_nullable
as bool,emailAccountType: freezed == emailAccountType ? _self.emailAccountType : emailAccountType // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of UserDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GeneralSettingsDtoCopyWith<$Res>? get generalSettings {
    if (_self.generalSettings == null) {
    return null;
  }

  return $GeneralSettingsDtoCopyWith<$Res>(_self.generalSettings!, (value) {
    return _then(_self.copyWith(generalSettings: value));
  });
}
}


/// @nodoc
@JsonSerializable()

class _UserDto implements UserDto {
  const _UserDto({required this.id, required this.fullName, required this.email, this.generalSettings, this.bio, this.role, this.imageId, this.imageUrl, this.verified = false, this.emailAccountType});
  factory _UserDto.fromJson(Map<String, dynamic> json) => _$UserDtoFromJson(json);

@override final  String id;
@override final  String fullName;
@override final  String email;
@override final  GeneralSettingsDto? generalSettings;
@override final  String? bio;
@override final  AuthRole? role;
@override final  String? imageId;
@override final  String? imageUrl;
@override@JsonKey() final  bool verified;
@override final  String? emailAccountType;

/// Create a copy of UserDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserDtoCopyWith<_UserDto> get copyWith => __$UserDtoCopyWithImpl<_UserDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserDto&&(identical(other.id, id) || other.id == id)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.email, email) || other.email == email)&&(identical(other.generalSettings, generalSettings) || other.generalSettings == generalSettings)&&(identical(other.bio, bio) || other.bio == bio)&&(identical(other.role, role) || other.role == role)&&(identical(other.imageId, imageId) || other.imageId == imageId)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.verified, verified) || other.verified == verified)&&(identical(other.emailAccountType, emailAccountType) || other.emailAccountType == emailAccountType));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,fullName,email,generalSettings,bio,role,imageId,imageUrl,verified,emailAccountType);

@override
String toString() {
  return 'UserDto(id: $id, fullName: $fullName, email: $email, generalSettings: $generalSettings, bio: $bio, role: $role, imageId: $imageId, imageUrl: $imageUrl, verified: $verified, emailAccountType: $emailAccountType)';
}


}

/// @nodoc
abstract mixin class _$UserDtoCopyWith<$Res> implements $UserDtoCopyWith<$Res> {
  factory _$UserDtoCopyWith(_UserDto value, $Res Function(_UserDto) _then) = __$UserDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String fullName, String email, GeneralSettingsDto? generalSettings, String? bio, AuthRole? role, String? imageId, String? imageUrl, bool verified, String? emailAccountType
});


@override $GeneralSettingsDtoCopyWith<$Res>? get generalSettings;

}
/// @nodoc
class __$UserDtoCopyWithImpl<$Res>
    implements _$UserDtoCopyWith<$Res> {
  __$UserDtoCopyWithImpl(this._self, this._then);

  final _UserDto _self;
  final $Res Function(_UserDto) _then;

/// Create a copy of UserDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? fullName = null,Object? email = null,Object? generalSettings = freezed,Object? bio = freezed,Object? role = freezed,Object? imageId = freezed,Object? imageUrl = freezed,Object? verified = null,Object? emailAccountType = freezed,}) {
  return _then(_UserDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,generalSettings: freezed == generalSettings ? _self.generalSettings : generalSettings // ignore: cast_nullable_to_non_nullable
as GeneralSettingsDto?,bio: freezed == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String?,role: freezed == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as AuthRole?,imageId: freezed == imageId ? _self.imageId : imageId // ignore: cast_nullable_to_non_nullable
as String?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,verified: null == verified ? _self.verified : verified // ignore: cast_nullable_to_non_nullable
as bool,emailAccountType: freezed == emailAccountType ? _self.emailAccountType : emailAccountType // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of UserDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GeneralSettingsDtoCopyWith<$Res>? get generalSettings {
    if (_self.generalSettings == null) {
    return null;
  }

  return $GeneralSettingsDtoCopyWith<$Res>(_self.generalSettings!, (value) {
    return _then(_self.copyWith(generalSettings: value));
  });
}
}

// dart format on
