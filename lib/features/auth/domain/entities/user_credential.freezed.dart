// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_credential.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UserCredential {

/// The user.
 User get user;/// The user's token.
 Token? get token;
/// Create a copy of UserCredential
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserCredentialCopyWith<UserCredential> get copyWith => _$UserCredentialCopyWithImpl<UserCredential>(this as UserCredential, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserCredential&&(identical(other.user, user) || other.user == user)&&(identical(other.token, token) || other.token == token));
}


@override
int get hashCode => Object.hash(runtimeType,user,token);

@override
String toString() {
  return 'UserCredential(user: $user, token: $token)';
}


}

/// @nodoc
abstract mixin class $UserCredentialCopyWith<$Res>  {
  factory $UserCredentialCopyWith(UserCredential value, $Res Function(UserCredential) _then) = _$UserCredentialCopyWithImpl;
@useResult
$Res call({
 User user, Token? token
});


$UserCopyWith<$Res> get user;

}
/// @nodoc
class _$UserCredentialCopyWithImpl<$Res>
    implements $UserCredentialCopyWith<$Res> {
  _$UserCredentialCopyWithImpl(this._self, this._then);

  final UserCredential _self;
  final $Res Function(UserCredential) _then;

/// Create a copy of UserCredential
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? user = null,Object? token = freezed,}) {
  return _then(_self.copyWith(
user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as User,token: freezed == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as Token?,
  ));
}
/// Create a copy of UserCredential
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserCopyWith<$Res> get user {
  
  return $UserCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}


/// @nodoc


class _UserCredential implements UserCredential {
  const _UserCredential({required this.user, this.token});
  

/// The user.
@override final  User user;
/// The user's token.
@override final  Token? token;

/// Create a copy of UserCredential
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserCredentialCopyWith<_UserCredential> get copyWith => __$UserCredentialCopyWithImpl<_UserCredential>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserCredential&&(identical(other.user, user) || other.user == user)&&(identical(other.token, token) || other.token == token));
}


@override
int get hashCode => Object.hash(runtimeType,user,token);

@override
String toString() {
  return 'UserCredential(user: $user, token: $token)';
}


}

/// @nodoc
abstract mixin class _$UserCredentialCopyWith<$Res> implements $UserCredentialCopyWith<$Res> {
  factory _$UserCredentialCopyWith(_UserCredential value, $Res Function(_UserCredential) _then) = __$UserCredentialCopyWithImpl;
@override @useResult
$Res call({
 User user, Token? token
});


@override $UserCopyWith<$Res> get user;

}
/// @nodoc
class __$UserCredentialCopyWithImpl<$Res>
    implements _$UserCredentialCopyWith<$Res> {
  __$UserCredentialCopyWithImpl(this._self, this._then);

  final _UserCredential _self;
  final $Res Function(_UserCredential) _then;

/// Create a copy of UserCredential
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? user = null,Object? token = freezed,}) {
  return _then(_UserCredential(
user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as User,token: freezed == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as Token?,
  ));
}

/// Create a copy of UserCredential
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserCopyWith<$Res> get user {
  
  return $UserCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}

// dart format on
