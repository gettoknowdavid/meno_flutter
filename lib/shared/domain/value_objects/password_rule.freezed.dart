// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'password_rule.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PasswordRule {

 String get code; String get message; bool get isValid;
/// Create a copy of PasswordRule
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PasswordRuleCopyWith<PasswordRule> get copyWith => _$PasswordRuleCopyWithImpl<PasswordRule>(this as PasswordRule, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PasswordRule&&(identical(other.code, code) || other.code == code)&&(identical(other.message, message) || other.message == message)&&(identical(other.isValid, isValid) || other.isValid == isValid));
}


@override
int get hashCode => Object.hash(runtimeType,code,message,isValid);

@override
String toString() {
  return 'PasswordRule(code: $code, message: $message, isValid: $isValid)';
}


}

/// @nodoc
abstract mixin class $PasswordRuleCopyWith<$Res>  {
  factory $PasswordRuleCopyWith(PasswordRule value, $Res Function(PasswordRule) _then) = _$PasswordRuleCopyWithImpl;
@useResult
$Res call({
 String code, String message, bool isValid
});




}
/// @nodoc
class _$PasswordRuleCopyWithImpl<$Res>
    implements $PasswordRuleCopyWith<$Res> {
  _$PasswordRuleCopyWithImpl(this._self, this._then);

  final PasswordRule _self;
  final $Res Function(PasswordRule) _then;

/// Create a copy of PasswordRule
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? message = null,Object? isValid = null,}) {
  return _then(_self.copyWith(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,isValid: null == isValid ? _self.isValid : isValid // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// @nodoc


class _PasswordRule implements PasswordRule {
  const _PasswordRule({required this.code, required this.message, required this.isValid});
  

@override final  String code;
@override final  String message;
@override final  bool isValid;

/// Create a copy of PasswordRule
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PasswordRuleCopyWith<_PasswordRule> get copyWith => __$PasswordRuleCopyWithImpl<_PasswordRule>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PasswordRule&&(identical(other.code, code) || other.code == code)&&(identical(other.message, message) || other.message == message)&&(identical(other.isValid, isValid) || other.isValid == isValid));
}


@override
int get hashCode => Object.hash(runtimeType,code,message,isValid);

@override
String toString() {
  return 'PasswordRule(code: $code, message: $message, isValid: $isValid)';
}


}

/// @nodoc
abstract mixin class _$PasswordRuleCopyWith<$Res> implements $PasswordRuleCopyWith<$Res> {
  factory _$PasswordRuleCopyWith(_PasswordRule value, $Res Function(_PasswordRule) _then) = __$PasswordRuleCopyWithImpl;
@override @useResult
$Res call({
 String code, String message, bool isValid
});




}
/// @nodoc
class __$PasswordRuleCopyWithImpl<$Res>
    implements _$PasswordRuleCopyWith<$Res> {
  __$PasswordRuleCopyWithImpl(this._self, this._then);

  final _PasswordRule _self;
  final $Res Function(_PasswordRule) _then;

/// Create a copy of PasswordRule
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? message = null,Object? isValid = null,}) {
  return _then(_PasswordRule(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,isValid: null == isValid ? _self.isValid : isValid // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
