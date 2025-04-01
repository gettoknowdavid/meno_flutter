// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_credential_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserCredentialDto {

 UserDto get user; String get token;
/// Create a copy of UserCredentialDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserCredentialDtoCopyWith<UserCredentialDto> get copyWith => _$UserCredentialDtoCopyWithImpl<UserCredentialDto>(this as UserCredentialDto, _$identity);

  /// Serializes this UserCredentialDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserCredentialDto&&(identical(other.user, user) || other.user == user)&&(identical(other.token, token) || other.token == token));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,user,token);

@override
String toString() {
  return 'UserCredentialDto(user: $user, token: $token)';
}


}

/// @nodoc
abstract mixin class $UserCredentialDtoCopyWith<$Res>  {
  factory $UserCredentialDtoCopyWith(UserCredentialDto value, $Res Function(UserCredentialDto) _then) = _$UserCredentialDtoCopyWithImpl;
@useResult
$Res call({
 UserDto user, String token
});


$UserDtoCopyWith<$Res> get user;

}
/// @nodoc
class _$UserCredentialDtoCopyWithImpl<$Res>
    implements $UserCredentialDtoCopyWith<$Res> {
  _$UserCredentialDtoCopyWithImpl(this._self, this._then);

  final UserCredentialDto _self;
  final $Res Function(UserCredentialDto) _then;

/// Create a copy of UserCredentialDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? user = null,Object? token = null,}) {
  return _then(_self.copyWith(
user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as UserDto,token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,
  ));
}
/// Create a copy of UserCredentialDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserDtoCopyWith<$Res> get user {
  
  return $UserDtoCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}


/// @nodoc
@JsonSerializable()

class _UserCredentialDto implements UserCredentialDto {
  const _UserCredentialDto({required this.user, required this.token});
  factory _UserCredentialDto.fromJson(Map<String, dynamic> json) => _$UserCredentialDtoFromJson(json);

@override final  UserDto user;
@override final  String token;

/// Create a copy of UserCredentialDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserCredentialDtoCopyWith<_UserCredentialDto> get copyWith => __$UserCredentialDtoCopyWithImpl<_UserCredentialDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserCredentialDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserCredentialDto&&(identical(other.user, user) || other.user == user)&&(identical(other.token, token) || other.token == token));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,user,token);

@override
String toString() {
  return 'UserCredentialDto(user: $user, token: $token)';
}


}

/// @nodoc
abstract mixin class _$UserCredentialDtoCopyWith<$Res> implements $UserCredentialDtoCopyWith<$Res> {
  factory _$UserCredentialDtoCopyWith(_UserCredentialDto value, $Res Function(_UserCredentialDto) _then) = __$UserCredentialDtoCopyWithImpl;
@override @useResult
$Res call({
 UserDto user, String token
});


@override $UserDtoCopyWith<$Res> get user;

}
/// @nodoc
class __$UserCredentialDtoCopyWithImpl<$Res>
    implements _$UserCredentialDtoCopyWith<$Res> {
  __$UserCredentialDtoCopyWithImpl(this._self, this._then);

  final _UserCredentialDto _self;
  final $Res Function(_UserCredentialDto) _then;

/// Create a copy of UserCredentialDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? user = null,Object? token = null,}) {
  return _then(_UserCredentialDto(
user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as UserDto,token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of UserCredentialDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserDtoCopyWith<$Res> get user {
  
  return $UserDtoCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}

// dart format on
