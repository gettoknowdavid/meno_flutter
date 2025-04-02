// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'session.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SessionState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SessionState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SessionState()';
}


}

/// @nodoc
class $SessionStateCopyWith<$Res>  {
$SessionStateCopyWith(SessionState _, $Res Function(SessionState) __);
}


/// @nodoc


class SessionLoading implements SessionState {
  const SessionLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SessionLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SessionState.loading()';
}


}




/// @nodoc


class SessionUnauthenticated implements SessionState {
  const SessionUnauthenticated();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SessionUnauthenticated);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SessionState.unauthenticated()';
}


}




/// @nodoc


class SessionAuthenticated implements SessionState {
  const SessionAuthenticated(this.user, this.token);
  

 final  User user;
 final  Token token;

/// Create a copy of SessionState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SessionAuthenticatedCopyWith<SessionAuthenticated> get copyWith => _$SessionAuthenticatedCopyWithImpl<SessionAuthenticated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SessionAuthenticated&&(identical(other.user, user) || other.user == user)&&(identical(other.token, token) || other.token == token));
}


@override
int get hashCode => Object.hash(runtimeType,user,token);

@override
String toString() {
  return 'SessionState.authenticated(user: $user, token: $token)';
}


}

/// @nodoc
abstract mixin class $SessionAuthenticatedCopyWith<$Res> implements $SessionStateCopyWith<$Res> {
  factory $SessionAuthenticatedCopyWith(SessionAuthenticated value, $Res Function(SessionAuthenticated) _then) = _$SessionAuthenticatedCopyWithImpl;
@useResult
$Res call({
 User user, Token token
});


$UserCopyWith<$Res> get user;

}
/// @nodoc
class _$SessionAuthenticatedCopyWithImpl<$Res>
    implements $SessionAuthenticatedCopyWith<$Res> {
  _$SessionAuthenticatedCopyWithImpl(this._self, this._then);

  final SessionAuthenticated _self;
  final $Res Function(SessionAuthenticated) _then;

/// Create a copy of SessionState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? user = null,Object? token = null,}) {
  return _then(SessionAuthenticated(
null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as User,null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as Token,
  ));
}

/// Create a copy of SessionState
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
