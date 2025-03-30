// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_setting.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$NotificationSetting {

 String get text; String get type; bool get value;
/// Create a copy of NotificationSetting
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationSettingCopyWith<NotificationSetting> get copyWith => _$NotificationSettingCopyWithImpl<NotificationSetting>(this as NotificationSetting, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationSetting&&(identical(other.text, text) || other.text == text)&&(identical(other.type, type) || other.type == type)&&(identical(other.value, value) || other.value == value));
}


@override
int get hashCode => Object.hash(runtimeType,text,type,value);

@override
String toString() {
  return 'NotificationSetting(text: $text, type: $type, value: $value)';
}


}

/// @nodoc
abstract mixin class $NotificationSettingCopyWith<$Res>  {
  factory $NotificationSettingCopyWith(NotificationSetting value, $Res Function(NotificationSetting) _then) = _$NotificationSettingCopyWithImpl;
@useResult
$Res call({
 String text, String type, bool value
});




}
/// @nodoc
class _$NotificationSettingCopyWithImpl<$Res>
    implements $NotificationSettingCopyWith<$Res> {
  _$NotificationSettingCopyWithImpl(this._self, this._then);

  final NotificationSetting _self;
  final $Res Function(NotificationSetting) _then;

/// Create a copy of NotificationSetting
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


class _NotificationSetting implements NotificationSetting {
  const _NotificationSetting({required this.text, required this.type, required this.value});
  

@override final  String text;
@override final  String type;
@override final  bool value;

/// Create a copy of NotificationSetting
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationSettingCopyWith<_NotificationSetting> get copyWith => __$NotificationSettingCopyWithImpl<_NotificationSetting>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationSetting&&(identical(other.text, text) || other.text == text)&&(identical(other.type, type) || other.type == type)&&(identical(other.value, value) || other.value == value));
}


@override
int get hashCode => Object.hash(runtimeType,text,type,value);

@override
String toString() {
  return 'NotificationSetting(text: $text, type: $type, value: $value)';
}


}

/// @nodoc
abstract mixin class _$NotificationSettingCopyWith<$Res> implements $NotificationSettingCopyWith<$Res> {
  factory _$NotificationSettingCopyWith(_NotificationSetting value, $Res Function(_NotificationSetting) _then) = __$NotificationSettingCopyWithImpl;
@override @useResult
$Res call({
 String text, String type, bool value
});




}
/// @nodoc
class __$NotificationSettingCopyWithImpl<$Res>
    implements _$NotificationSettingCopyWith<$Res> {
  __$NotificationSettingCopyWithImpl(this._self, this._then);

  final _NotificationSetting _self;
  final $Res Function(_NotificationSetting) _then;

/// Create a copy of NotificationSetting
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? text = null,Object? type = null,Object? value = null,}) {
  return _then(_NotificationSetting(
text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
