// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'base_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BaseResponse<T> {

 int get statusCode; String get message; bool get success; bool get status; T? get data; String? get path; dynamic get error;
/// Create a copy of BaseResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BaseResponseCopyWith<T, BaseResponse<T>> get copyWith => _$BaseResponseCopyWithImpl<T, BaseResponse<T>>(this as BaseResponse<T>, _$identity);

  /// Serializes this BaseResponse to a JSON map.
  Map<String, dynamic> toJson(Object? Function(T) toJsonT);


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BaseResponse<T>&&(identical(other.statusCode, statusCode) || other.statusCode == statusCode)&&(identical(other.message, message) || other.message == message)&&(identical(other.success, success) || other.success == success)&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.data, data)&&(identical(other.path, path) || other.path == path)&&const DeepCollectionEquality().equals(other.error, error));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,statusCode,message,success,status,const DeepCollectionEquality().hash(data),path,const DeepCollectionEquality().hash(error));

@override
String toString() {
  return 'BaseResponse<$T>(statusCode: $statusCode, message: $message, success: $success, status: $status, data: $data, path: $path, error: $error)';
}


}

/// @nodoc
abstract mixin class $BaseResponseCopyWith<T,$Res>  {
  factory $BaseResponseCopyWith(BaseResponse<T> value, $Res Function(BaseResponse<T>) _then) = _$BaseResponseCopyWithImpl;
@useResult
$Res call({
 int statusCode, String message, bool success, bool status, T? data, String? path, dynamic error
});




}
/// @nodoc
class _$BaseResponseCopyWithImpl<T,$Res>
    implements $BaseResponseCopyWith<T, $Res> {
  _$BaseResponseCopyWithImpl(this._self, this._then);

  final BaseResponse<T> _self;
  final $Res Function(BaseResponse<T>) _then;

/// Create a copy of BaseResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? statusCode = null,Object? message = null,Object? success = null,Object? status = null,Object? data = freezed,Object? path = freezed,Object? error = freezed,}) {
  return _then(_self.copyWith(
statusCode: null == statusCode ? _self.statusCode : statusCode // ignore: cast_nullable_to_non_nullable
as int,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as bool,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as T?,path: freezed == path ? _self.path : path // ignore: cast_nullable_to_non_nullable
as String?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}

}


/// @nodoc
@JsonSerializable(genericArgumentFactories: true)

class _BaseResponse<T> implements BaseResponse<T> {
  const _BaseResponse({required this.statusCode, this.message = '', this.success = false, this.status = false, this.data, this.path, this.error});
  factory _BaseResponse.fromJson(Map<String, dynamic> json,T Function(Object?) fromJsonT) => _$BaseResponseFromJson(json,fromJsonT);

@override final  int statusCode;
@override@JsonKey() final  String message;
@override@JsonKey() final  bool success;
@override@JsonKey() final  bool status;
@override final  T? data;
@override final  String? path;
@override final  dynamic error;

/// Create a copy of BaseResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BaseResponseCopyWith<T, _BaseResponse<T>> get copyWith => __$BaseResponseCopyWithImpl<T, _BaseResponse<T>>(this, _$identity);

@override
Map<String, dynamic> toJson(Object? Function(T) toJsonT) {
  return _$BaseResponseToJson<T>(this, toJsonT);
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BaseResponse<T>&&(identical(other.statusCode, statusCode) || other.statusCode == statusCode)&&(identical(other.message, message) || other.message == message)&&(identical(other.success, success) || other.success == success)&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.data, data)&&(identical(other.path, path) || other.path == path)&&const DeepCollectionEquality().equals(other.error, error));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,statusCode,message,success,status,const DeepCollectionEquality().hash(data),path,const DeepCollectionEquality().hash(error));

@override
String toString() {
  return 'BaseResponse<$T>(statusCode: $statusCode, message: $message, success: $success, status: $status, data: $data, path: $path, error: $error)';
}


}

/// @nodoc
abstract mixin class _$BaseResponseCopyWith<T,$Res> implements $BaseResponseCopyWith<T, $Res> {
  factory _$BaseResponseCopyWith(_BaseResponse<T> value, $Res Function(_BaseResponse<T>) _then) = __$BaseResponseCopyWithImpl;
@override @useResult
$Res call({
 int statusCode, String message, bool success, bool status, T? data, String? path, dynamic error
});




}
/// @nodoc
class __$BaseResponseCopyWithImpl<T,$Res>
    implements _$BaseResponseCopyWith<T, $Res> {
  __$BaseResponseCopyWithImpl(this._self, this._then);

  final _BaseResponse<T> _self;
  final $Res Function(_BaseResponse<T>) _then;

/// Create a copy of BaseResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? statusCode = null,Object? message = null,Object? success = null,Object? status = null,Object? data = freezed,Object? path = freezed,Object? error = freezed,}) {
  return _then(_BaseResponse<T>(
statusCode: null == statusCode ? _self.statusCode : statusCode // ignore: cast_nullable_to_non_nullable
as int,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as bool,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as T?,path: freezed == path ? _self.path : path // ignore: cast_nullable_to_non_nullable
as String?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}


}

// dart format on
