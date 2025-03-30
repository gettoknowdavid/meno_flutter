// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'value_exception.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ValueException<T> {

 String get code; String get message;
/// Create a copy of ValueException
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ValueExceptionCopyWith<T, ValueException<T>> get copyWith => _$ValueExceptionCopyWithImpl<T, ValueException<T>>(this as ValueException<T>, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ValueException<T>&&(identical(other.code, code) || other.code == code)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,code,message);

@override
String toString() {
  return 'ValueException<$T>(code: $code, message: $message)';
}


}

/// @nodoc
abstract mixin class $ValueExceptionCopyWith<T,$Res>  {
  factory $ValueExceptionCopyWith(ValueException<T> value, $Res Function(ValueException<T>) _then) = _$ValueExceptionCopyWithImpl;
@useResult
$Res call({
 String code, String message
});




}
/// @nodoc
class _$ValueExceptionCopyWithImpl<T,$Res>
    implements $ValueExceptionCopyWith<T, $Res> {
  _$ValueExceptionCopyWithImpl(this._self, this._then);

  final ValueException<T> _self;
  final $Res Function(ValueException<T>) _then;

/// Create a copy of ValueException
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? message = null,}) {
  return _then(_self.copyWith(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc


class RequiredValueException<T> implements ValueException<T> {
  const RequiredValueException({this.code = 'required-value', this.message = 'This value cannot be empty.'});
  

@override@JsonKey() final  String code;
@override@JsonKey() final  String message;

/// Create a copy of ValueException
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RequiredValueExceptionCopyWith<T, RequiredValueException<T>> get copyWith => _$RequiredValueExceptionCopyWithImpl<T, RequiredValueException<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RequiredValueException<T>&&(identical(other.code, code) || other.code == code)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,code,message);

@override
String toString() {
  return 'ValueException<$T>.required(code: $code, message: $message)';
}


}

/// @nodoc
abstract mixin class $RequiredValueExceptionCopyWith<T,$Res> implements $ValueExceptionCopyWith<T, $Res> {
  factory $RequiredValueExceptionCopyWith(RequiredValueException<T> value, $Res Function(RequiredValueException<T>) _then) = _$RequiredValueExceptionCopyWithImpl;
@override @useResult
$Res call({
 String code, String message
});




}
/// @nodoc
class _$RequiredValueExceptionCopyWithImpl<T,$Res>
    implements $RequiredValueExceptionCopyWith<T, $Res> {
  _$RequiredValueExceptionCopyWithImpl(this._self, this._then);

  final RequiredValueException<T> _self;
  final $Res Function(RequiredValueException<T>) _then;

/// Create a copy of ValueException
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? message = null,}) {
  return _then(RequiredValueException<T>(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class InvalidValueException<T> implements ValueException<T> {
  const InvalidValueException(this.invalidValue, {this.code = 'invalid-value', this.message = 'Invalid value.'});
  

 final  T invalidValue;
@override@JsonKey() final  String code;
@override@JsonKey() final  String message;

/// Create a copy of ValueException
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InvalidValueExceptionCopyWith<T, InvalidValueException<T>> get copyWith => _$InvalidValueExceptionCopyWithImpl<T, InvalidValueException<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InvalidValueException<T>&&const DeepCollectionEquality().equals(other.invalidValue, invalidValue)&&(identical(other.code, code) || other.code == code)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(invalidValue),code,message);

@override
String toString() {
  return 'ValueException<$T>.invalid(invalidValue: $invalidValue, code: $code, message: $message)';
}


}

/// @nodoc
abstract mixin class $InvalidValueExceptionCopyWith<T,$Res> implements $ValueExceptionCopyWith<T, $Res> {
  factory $InvalidValueExceptionCopyWith(InvalidValueException<T> value, $Res Function(InvalidValueException<T>) _then) = _$InvalidValueExceptionCopyWithImpl;
@override @useResult
$Res call({
 T invalidValue, String code, String message
});




}
/// @nodoc
class _$InvalidValueExceptionCopyWithImpl<T,$Res>
    implements $InvalidValueExceptionCopyWith<T, $Res> {
  _$InvalidValueExceptionCopyWithImpl(this._self, this._then);

  final InvalidValueException<T> _self;
  final $Res Function(InvalidValueException<T>) _then;

/// Create a copy of ValueException
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? invalidValue = freezed,Object? code = null,Object? message = null,}) {
  return _then(InvalidValueException<T>(
freezed == invalidValue ? _self.invalidValue : invalidValue // ignore: cast_nullable_to_non_nullable
as T,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class LengthExceededValueException<T> implements ValueException<T> {
  const LengthExceededValueException(this.invalidValue, {this.code = 'length-exceeded', this.message = 'Value length has been exceeded.'});
  

 final  T invalidValue;
@override@JsonKey() final  String code;
@override@JsonKey() final  String message;

/// Create a copy of ValueException
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LengthExceededValueExceptionCopyWith<T, LengthExceededValueException<T>> get copyWith => _$LengthExceededValueExceptionCopyWithImpl<T, LengthExceededValueException<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LengthExceededValueException<T>&&const DeepCollectionEquality().equals(other.invalidValue, invalidValue)&&(identical(other.code, code) || other.code == code)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(invalidValue),code,message);

@override
String toString() {
  return 'ValueException<$T>.lengthExceeded(invalidValue: $invalidValue, code: $code, message: $message)';
}


}

/// @nodoc
abstract mixin class $LengthExceededValueExceptionCopyWith<T,$Res> implements $ValueExceptionCopyWith<T, $Res> {
  factory $LengthExceededValueExceptionCopyWith(LengthExceededValueException<T> value, $Res Function(LengthExceededValueException<T>) _then) = _$LengthExceededValueExceptionCopyWithImpl;
@override @useResult
$Res call({
 T invalidValue, String code, String message
});




}
/// @nodoc
class _$LengthExceededValueExceptionCopyWithImpl<T,$Res>
    implements $LengthExceededValueExceptionCopyWith<T, $Res> {
  _$LengthExceededValueExceptionCopyWithImpl(this._self, this._then);

  final LengthExceededValueException<T> _self;
  final $Res Function(LengthExceededValueException<T>) _then;

/// Create a copy of ValueException
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? invalidValue = freezed,Object? code = null,Object? message = null,}) {
  return _then(LengthExceededValueException<T>(
freezed == invalidValue ? _self.invalidValue : invalidValue // ignore: cast_nullable_to_non_nullable
as T,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class MaxLinesExceededValueException<T> implements ValueException<T> {
  const MaxLinesExceededValueException(this.invalidValue, {this.code = 'max-lines-exceeded', this.message = 'Number of valid lines has been exceeded.'});
  

 final  T invalidValue;
@override@JsonKey() final  String code;
@override@JsonKey() final  String message;

/// Create a copy of ValueException
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MaxLinesExceededValueExceptionCopyWith<T, MaxLinesExceededValueException<T>> get copyWith => _$MaxLinesExceededValueExceptionCopyWithImpl<T, MaxLinesExceededValueException<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MaxLinesExceededValueException<T>&&const DeepCollectionEquality().equals(other.invalidValue, invalidValue)&&(identical(other.code, code) || other.code == code)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(invalidValue),code,message);

@override
String toString() {
  return 'ValueException<$T>.maxLinesExceeded(invalidValue: $invalidValue, code: $code, message: $message)';
}


}

/// @nodoc
abstract mixin class $MaxLinesExceededValueExceptionCopyWith<T,$Res> implements $ValueExceptionCopyWith<T, $Res> {
  factory $MaxLinesExceededValueExceptionCopyWith(MaxLinesExceededValueException<T> value, $Res Function(MaxLinesExceededValueException<T>) _then) = _$MaxLinesExceededValueExceptionCopyWithImpl;
@override @useResult
$Res call({
 T invalidValue, String code, String message
});




}
/// @nodoc
class _$MaxLinesExceededValueExceptionCopyWithImpl<T,$Res>
    implements $MaxLinesExceededValueExceptionCopyWith<T, $Res> {
  _$MaxLinesExceededValueExceptionCopyWithImpl(this._self, this._then);

  final MaxLinesExceededValueException<T> _self;
  final $Res Function(MaxLinesExceededValueException<T>) _then;

/// Create a copy of ValueException
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? invalidValue = freezed,Object? code = null,Object? message = null,}) {
  return _then(MaxLinesExceededValueException<T>(
freezed == invalidValue ? _self.invalidValue : invalidValue // ignore: cast_nullable_to_non_nullable
as T,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class InvalidFileFormatException<T> implements ValueException<T> {
  const InvalidFileFormatException(this.invalidValue, {this.code = 'invalid-format', this.message = 'The file format selected is invalid.'});
  

 final  T invalidValue;
@override@JsonKey() final  String code;
@override@JsonKey() final  String message;

/// Create a copy of ValueException
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InvalidFileFormatExceptionCopyWith<T, InvalidFileFormatException<T>> get copyWith => _$InvalidFileFormatExceptionCopyWithImpl<T, InvalidFileFormatException<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InvalidFileFormatException<T>&&const DeepCollectionEquality().equals(other.invalidValue, invalidValue)&&(identical(other.code, code) || other.code == code)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(invalidValue),code,message);

@override
String toString() {
  return 'ValueException<$T>.invalidFormat(invalidValue: $invalidValue, code: $code, message: $message)';
}


}

/// @nodoc
abstract mixin class $InvalidFileFormatExceptionCopyWith<T,$Res> implements $ValueExceptionCopyWith<T, $Res> {
  factory $InvalidFileFormatExceptionCopyWith(InvalidFileFormatException<T> value, $Res Function(InvalidFileFormatException<T>) _then) = _$InvalidFileFormatExceptionCopyWithImpl;
@override @useResult
$Res call({
 T invalidValue, String code, String message
});




}
/// @nodoc
class _$InvalidFileFormatExceptionCopyWithImpl<T,$Res>
    implements $InvalidFileFormatExceptionCopyWith<T, $Res> {
  _$InvalidFileFormatExceptionCopyWithImpl(this._self, this._then);

  final InvalidFileFormatException<T> _self;
  final $Res Function(InvalidFileFormatException<T>) _then;

/// Create a copy of ValueException
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? invalidValue = freezed,Object? code = null,Object? message = null,}) {
  return _then(InvalidFileFormatException<T>(
freezed == invalidValue ? _self.invalidValue : invalidValue // ignore: cast_nullable_to_non_nullable
as T,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
