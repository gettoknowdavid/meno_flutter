// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'general_settings_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GeneralSettingsDto {

 String get id; String get userId; List<NotificationSettingDto> get notificationSettings; bool get pushNotifications; bool get appNotifications; bool get emailNotifications; String get display; String get language; String? get pushNotificationToken;
/// Create a copy of GeneralSettingsDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GeneralSettingsDtoCopyWith<GeneralSettingsDto> get copyWith => _$GeneralSettingsDtoCopyWithImpl<GeneralSettingsDto>(this as GeneralSettingsDto, _$identity);

  /// Serializes this GeneralSettingsDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GeneralSettingsDto&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&const DeepCollectionEquality().equals(other.notificationSettings, notificationSettings)&&(identical(other.pushNotifications, pushNotifications) || other.pushNotifications == pushNotifications)&&(identical(other.appNotifications, appNotifications) || other.appNotifications == appNotifications)&&(identical(other.emailNotifications, emailNotifications) || other.emailNotifications == emailNotifications)&&(identical(other.display, display) || other.display == display)&&(identical(other.language, language) || other.language == language)&&(identical(other.pushNotificationToken, pushNotificationToken) || other.pushNotificationToken == pushNotificationToken));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,const DeepCollectionEquality().hash(notificationSettings),pushNotifications,appNotifications,emailNotifications,display,language,pushNotificationToken);

@override
String toString() {
  return 'GeneralSettingsDto(id: $id, userId: $userId, notificationSettings: $notificationSettings, pushNotifications: $pushNotifications, appNotifications: $appNotifications, emailNotifications: $emailNotifications, display: $display, language: $language, pushNotificationToken: $pushNotificationToken)';
}


}

/// @nodoc
abstract mixin class $GeneralSettingsDtoCopyWith<$Res>  {
  factory $GeneralSettingsDtoCopyWith(GeneralSettingsDto value, $Res Function(GeneralSettingsDto) _then) = _$GeneralSettingsDtoCopyWithImpl;
@useResult
$Res call({
 String id, String userId, List<NotificationSettingDto> notificationSettings, bool pushNotifications, bool appNotifications, bool emailNotifications, String display, String language, String? pushNotificationToken
});




}
/// @nodoc
class _$GeneralSettingsDtoCopyWithImpl<$Res>
    implements $GeneralSettingsDtoCopyWith<$Res> {
  _$GeneralSettingsDtoCopyWithImpl(this._self, this._then);

  final GeneralSettingsDto _self;
  final $Res Function(GeneralSettingsDto) _then;

/// Create a copy of GeneralSettingsDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? notificationSettings = null,Object? pushNotifications = null,Object? appNotifications = null,Object? emailNotifications = null,Object? display = null,Object? language = null,Object? pushNotificationToken = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,notificationSettings: null == notificationSettings ? _self.notificationSettings : notificationSettings // ignore: cast_nullable_to_non_nullable
as List<NotificationSettingDto>,pushNotifications: null == pushNotifications ? _self.pushNotifications : pushNotifications // ignore: cast_nullable_to_non_nullable
as bool,appNotifications: null == appNotifications ? _self.appNotifications : appNotifications // ignore: cast_nullable_to_non_nullable
as bool,emailNotifications: null == emailNotifications ? _self.emailNotifications : emailNotifications // ignore: cast_nullable_to_non_nullable
as bool,display: null == display ? _self.display : display // ignore: cast_nullable_to_non_nullable
as String,language: null == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as String,pushNotificationToken: freezed == pushNotificationToken ? _self.pushNotificationToken : pushNotificationToken // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _GeneralSettingsDto implements GeneralSettingsDto {
  const _GeneralSettingsDto({required this.id, required this.userId, required final  List<NotificationSettingDto> notificationSettings, this.pushNotifications = false, this.appNotifications = true, this.emailNotifications = false, this.display = 'light', this.language = 'en/English', this.pushNotificationToken}): _notificationSettings = notificationSettings;
  factory _GeneralSettingsDto.fromJson(Map<String, dynamic> json) => _$GeneralSettingsDtoFromJson(json);

@override final  String id;
@override final  String userId;
 final  List<NotificationSettingDto> _notificationSettings;
@override List<NotificationSettingDto> get notificationSettings {
  if (_notificationSettings is EqualUnmodifiableListView) return _notificationSettings;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_notificationSettings);
}

@override@JsonKey() final  bool pushNotifications;
@override@JsonKey() final  bool appNotifications;
@override@JsonKey() final  bool emailNotifications;
@override@JsonKey() final  String display;
@override@JsonKey() final  String language;
@override final  String? pushNotificationToken;

/// Create a copy of GeneralSettingsDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GeneralSettingsDtoCopyWith<_GeneralSettingsDto> get copyWith => __$GeneralSettingsDtoCopyWithImpl<_GeneralSettingsDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GeneralSettingsDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GeneralSettingsDto&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&const DeepCollectionEquality().equals(other._notificationSettings, _notificationSettings)&&(identical(other.pushNotifications, pushNotifications) || other.pushNotifications == pushNotifications)&&(identical(other.appNotifications, appNotifications) || other.appNotifications == appNotifications)&&(identical(other.emailNotifications, emailNotifications) || other.emailNotifications == emailNotifications)&&(identical(other.display, display) || other.display == display)&&(identical(other.language, language) || other.language == language)&&(identical(other.pushNotificationToken, pushNotificationToken) || other.pushNotificationToken == pushNotificationToken));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,const DeepCollectionEquality().hash(_notificationSettings),pushNotifications,appNotifications,emailNotifications,display,language,pushNotificationToken);

@override
String toString() {
  return 'GeneralSettingsDto(id: $id, userId: $userId, notificationSettings: $notificationSettings, pushNotifications: $pushNotifications, appNotifications: $appNotifications, emailNotifications: $emailNotifications, display: $display, language: $language, pushNotificationToken: $pushNotificationToken)';
}


}

/// @nodoc
abstract mixin class _$GeneralSettingsDtoCopyWith<$Res> implements $GeneralSettingsDtoCopyWith<$Res> {
  factory _$GeneralSettingsDtoCopyWith(_GeneralSettingsDto value, $Res Function(_GeneralSettingsDto) _then) = __$GeneralSettingsDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String userId, List<NotificationSettingDto> notificationSettings, bool pushNotifications, bool appNotifications, bool emailNotifications, String display, String language, String? pushNotificationToken
});




}
/// @nodoc
class __$GeneralSettingsDtoCopyWithImpl<$Res>
    implements _$GeneralSettingsDtoCopyWith<$Res> {
  __$GeneralSettingsDtoCopyWithImpl(this._self, this._then);

  final _GeneralSettingsDto _self;
  final $Res Function(_GeneralSettingsDto) _then;

/// Create a copy of GeneralSettingsDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? notificationSettings = null,Object? pushNotifications = null,Object? appNotifications = null,Object? emailNotifications = null,Object? display = null,Object? language = null,Object? pushNotificationToken = freezed,}) {
  return _then(_GeneralSettingsDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,notificationSettings: null == notificationSettings ? _self._notificationSettings : notificationSettings // ignore: cast_nullable_to_non_nullable
as List<NotificationSettingDto>,pushNotifications: null == pushNotifications ? _self.pushNotifications : pushNotifications // ignore: cast_nullable_to_non_nullable
as bool,appNotifications: null == appNotifications ? _self.appNotifications : appNotifications // ignore: cast_nullable_to_non_nullable
as bool,emailNotifications: null == emailNotifications ? _self.emailNotifications : emailNotifications // ignore: cast_nullable_to_non_nullable
as bool,display: null == display ? _self.display : display // ignore: cast_nullable_to_non_nullable
as String,language: null == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as String,pushNotificationToken: freezed == pushNotificationToken ? _self.pushNotificationToken : pushNotificationToken // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
