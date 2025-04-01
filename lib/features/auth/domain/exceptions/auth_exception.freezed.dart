// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_exception.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AuthException {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthException);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthException()';
}


}

/// @nodoc
class $AuthExceptionCopyWith<$Res>  {
$AuthExceptionCopyWith(AuthException _, $Res Function(AuthException) __);
}


/// @nodoc


class AuthExceptionWithMessage implements AuthException {
  const AuthExceptionWithMessage(this.msg);
  

 final  String msg;

/// Create a copy of AuthException
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthExceptionWithMessageCopyWith<AuthExceptionWithMessage> get copyWith => _$AuthExceptionWithMessageCopyWithImpl<AuthExceptionWithMessage>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthExceptionWithMessage&&(identical(other.msg, msg) || other.msg == msg));
}


@override
int get hashCode => Object.hash(runtimeType,msg);

@override
String toString() {
  return 'AuthException.message(msg: $msg)';
}


}

/// @nodoc
abstract mixin class $AuthExceptionWithMessageCopyWith<$Res> implements $AuthExceptionCopyWith<$Res> {
  factory $AuthExceptionWithMessageCopyWith(AuthExceptionWithMessage value, $Res Function(AuthExceptionWithMessage) _then) = _$AuthExceptionWithMessageCopyWithImpl;
@useResult
$Res call({
 String msg
});




}
/// @nodoc
class _$AuthExceptionWithMessageCopyWithImpl<$Res>
    implements $AuthExceptionWithMessageCopyWith<$Res> {
  _$AuthExceptionWithMessageCopyWithImpl(this._self, this._then);

  final AuthExceptionWithMessage _self;
  final $Res Function(AuthExceptionWithMessage) _then;

/// Create a copy of AuthException
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? msg = null,}) {
  return _then(AuthExceptionWithMessage(
null == msg ? _self.msg : msg // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class NoCredentialsException implements AuthException {
  const NoCredentialsException();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NoCredentialsException);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthException.noCredentials()';
}


}




/// @nodoc


class InvalidEmailOrPasswordException implements AuthException {
  const InvalidEmailOrPasswordException();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InvalidEmailOrPasswordException);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthException.invalidEmailOrPassword()';
}


}




/// @nodoc


class UnableToVerifyEmailException implements AuthException {
  const UnableToVerifyEmailException();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UnableToVerifyEmailException);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthException.unableToVerifyEmail()';
}


}




/// @nodoc


class EmailAlreadyInUseException implements AuthException {
  const EmailAlreadyInUseException();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EmailAlreadyInUseException);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthException.emailAlreadyInUse()';
}


}




/// @nodoc


class AuthTokenExpiredException implements AuthException {
  const AuthTokenExpiredException();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthTokenExpiredException);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthException.tokenExpired()';
}


}




/// @nodoc


class UnknownAuthException implements AuthException {
  const UnknownAuthException();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UnknownAuthException);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthException.unknown()';
}


}




/// @nodoc


class AuthServerException implements AuthException {
  const AuthServerException();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthServerException);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthException.server()';
}


}




/// @nodoc


class AuthValidationException implements AuthException {
  const AuthValidationException(final  Map<String, dynamic> errors): _errors = errors;
  

 final  Map<String, dynamic> _errors;
 Map<String, dynamic> get errors {
  if (_errors is EqualUnmodifiableMapView) return _errors;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_errors);
}


/// Create a copy of AuthException
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthValidationExceptionCopyWith<AuthValidationException> get copyWith => _$AuthValidationExceptionCopyWithImpl<AuthValidationException>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthValidationException&&const DeepCollectionEquality().equals(other._errors, _errors));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_errors));

@override
String toString() {
  return 'AuthException.validation(errors: $errors)';
}


}

/// @nodoc
abstract mixin class $AuthValidationExceptionCopyWith<$Res> implements $AuthExceptionCopyWith<$Res> {
  factory $AuthValidationExceptionCopyWith(AuthValidationException value, $Res Function(AuthValidationException) _then) = _$AuthValidationExceptionCopyWithImpl;
@useResult
$Res call({
 Map<String, dynamic> errors
});




}
/// @nodoc
class _$AuthValidationExceptionCopyWithImpl<$Res>
    implements $AuthValidationExceptionCopyWith<$Res> {
  _$AuthValidationExceptionCopyWithImpl(this._self, this._then);

  final AuthValidationException _self;
  final $Res Function(AuthValidationException) _then;

/// Create a copy of AuthException
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? errors = null,}) {
  return _then(AuthValidationException(
null == errors ? _self._errors : errors // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}

// dart format on
