// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'meno_exception.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MenoException {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MenoException);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MenoException()';
}


}

/// @nodoc
class $MenoExceptionCopyWith<$Res>  {
$MenoExceptionCopyWith(MenoException _, $Res Function(MenoException) __);
}


/// @nodoc


class MenoExceptionWithMessage implements MenoException {
  const MenoExceptionWithMessage(this.msg);
  

 final  String msg;

/// Create a copy of MenoException
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MenoExceptionWithMessageCopyWith<MenoExceptionWithMessage> get copyWith => _$MenoExceptionWithMessageCopyWithImpl<MenoExceptionWithMessage>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MenoExceptionWithMessage&&(identical(other.msg, msg) || other.msg == msg));
}


@override
int get hashCode => Object.hash(runtimeType,msg);

@override
String toString() {
  return 'MenoException.message(msg: $msg)';
}


}

/// @nodoc
abstract mixin class $MenoExceptionWithMessageCopyWith<$Res> implements $MenoExceptionCopyWith<$Res> {
  factory $MenoExceptionWithMessageCopyWith(MenoExceptionWithMessage value, $Res Function(MenoExceptionWithMessage) _then) = _$MenoExceptionWithMessageCopyWithImpl;
@useResult
$Res call({
 String msg
});




}
/// @nodoc
class _$MenoExceptionWithMessageCopyWithImpl<$Res>
    implements $MenoExceptionWithMessageCopyWith<$Res> {
  _$MenoExceptionWithMessageCopyWithImpl(this._self, this._then);

  final MenoExceptionWithMessage _self;
  final $Res Function(MenoExceptionWithMessage) _then;

/// Create a copy of MenoException
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? msg = null,}) {
  return _then(MenoExceptionWithMessage(
null == msg ? _self.msg : msg // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class MenoServerException implements MenoException {
  const MenoServerException();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MenoServerException);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MenoException.serverError()';
}


}




/// @nodoc


class MenoNetworkException implements MenoException {
  const MenoNetworkException();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MenoNetworkException);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MenoException.networkError()';
}


}




/// @nodoc


class MenoTimeoutException implements MenoException {
  const MenoTimeoutException();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MenoTimeoutException);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MenoException.timeoutError()';
}


}




/// @nodoc


class MenoUnknownException implements MenoException {
  const MenoUnknownException();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MenoUnknownException);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MenoException.unknownError()';
}


}




// dart format on
