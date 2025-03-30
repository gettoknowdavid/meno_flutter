// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_setting_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NotificationSettingDto {

 String get text; String get type; bool get value;
/// Create a copy of NotificationSettingDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationSettingDtoCopyWith<NotificationSettingDto> get copyWith => _$NotificationSettingDtoCopyWithImpl<NotificationSettingDto>(this as NotificationSettingDto, _$identity);

  /// Serializes this NotificationSettingDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationSettingDto&&(identical(other.text, text) || other.text == text)&&(identical(other.type, type) || other.type == type)&&(identical(other.value, value) || other.value == value));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,text,type,value);

@override
String toString() {
  return 'NotificationSettingDto(text: $text, type: $type, value: $value)';
}


}

/// @nodoc
abstract mixin class $NotificationSettingDtoCopyWith<$Res>  {
  factory $NotificationSettingDtoCopyWith(NotificationSettingDto value, $Res Function(NotificationSettingDto) _then) = _$NotificationSettingDtoCopyWithImpl;
@useResult
$Res call({
 String text, String type, bool value
});




}
/// @nodoc
class _$NotificationSettingDtoCopyWithImpl<$Res>
    implements $NotificationSettingDtoCopyWith<$Res> {
  _$NotificationSettingDtoCopyWithImpl(this._self, this._then);

  final NotificationSettingDto _self;
  final $Res Function(NotificationSettingDto) _then;

/// Create a copy of NotificationSettingDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? text = null,Object? type = null,Object? value = null,}) {
  return _then(_self.copyWith(
text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _NotificationSettingDto implements NotificationSettingDto {
  const _NotificationSettingDto({required this.text, required this.type, required this.value});
  factory _NotificationSettingDto.fromJson(Map<String, dynamic> json) => _$NotificationSettingDtoFromJson(json);

@override final  String text;
@override final  String type;
@override final  bool value;

/// Create a copy of NotificationSettingDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationSettingDtoCopyWith<_NotificationSettingDto> get copyWith => __$NotificationSettingDtoCopyWithImpl<_NotificationSettingDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NotificationSettingDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationSettingDto&&(identical(other.text, text) || other.text == text)&&(identical(other.type, type) || other.type == type)&&(identical(other.value, value) || other.value == value));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,text,type,value);

@override
String toString() {
  return 'NotificationSettingDto(text: $text, type: $type, value: $value)';
}


}

/// @nodoc
abstract mixin class _$NotificationSettingDtoCopyWith<$Res> implements $NotificationSettingDtoCopyWith<$Res> {
  factory _$NotificationSettingDtoCopyWith(_NotificationSettingDto value, $Res Function(_NotificationSettingDto) _then) = __$NotificationSettingDtoCopyWithImpl;
@override @useResult
$Res call({
 String text, String type, bool value
});




}
/// @nodoc
class __$NotificationSettingDtoCopyWithImpl<$Res>
    implements _$NotificationSettingDtoCopyWith<$Res> {
  __$NotificationSettingDtoCopyWithImpl(this._self, this._then);

  final _NotificationSettingDto _self;
  final $Res Function(_NotificationSettingDto) _then;

/// Create a copy of NotificationSettingDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? text = null,Object? type = null,Object? value = null,}) {
  return _then(_NotificationSettingDto(
text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
