// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'general_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GeneralSettings {

 Id get id; Id get userId; List<NotificationSetting> get notificationSettings; bool get pushNotifications; bool get appNotifications; bool get emailNotifications; String get display; String get language; String? get pushNotificationToken;
/// Create a copy of GeneralSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GeneralSettingsCopyWith<GeneralSettings> get copyWith => _$GeneralSettingsCopyWithImpl<GeneralSettings>(this as GeneralSettings, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GeneralSettings&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&const DeepCollectionEquality().equals(other.notificationSettings, notificationSettings)&&(identical(other.pushNotifications, pushNotifications) || other.pushNotifications == pushNotifications)&&(identical(other.appNotifications, appNotifications) || other.appNotifications == appNotifications)&&(identical(other.emailNotifications, emailNotifications) || other.emailNotifications == emailNotifications)&&(identical(other.display, display) || other.display == display)&&(identical(other.language, language) || other.language == language)&&(identical(other.pushNotificationToken, pushNotificationToken) || other.pushNotificationToken == pushNotificationToken));
}


@override
int get hashCode => Object.hash(runtimeType,id,userId,const DeepCollectionEquality().hash(notificationSettings),pushNotifications,appNotifications,emailNotifications,display,language,pushNotificationToken);

@override
String toString() {
  return 'GeneralSettings(id: $id, userId: $userId, notificationSettings: $notificationSettings, pushNotifications: $pushNotifications, appNotifications: $appNotifications, emailNotifications: $emailNotifications, display: $display, language: $language, pushNotificationToken: $pushNotificationToken)';
}


}

/// @nodoc
abstract mixin class $GeneralSettingsCopyWith<$Res>  {
  factory $GeneralSettingsCopyWith(GeneralSettings value, $Res Function(GeneralSettings) _then) = _$GeneralSettingsCopyWithImpl;
@useResult
$Res call({
 Id id, Id userId, List<NotificationSetting> notificationSettings, bool pushNotifications, bool appNotifications, bool emailNotifications, String display, String language, String? pushNotificationToken
});




}
/// @nodoc
class _$GeneralSettingsCopyWithImpl<$Res>
    implements $GeneralSettingsCopyWith<$Res> {
  _$GeneralSettingsCopyWithImpl(this._self, this._then);

  final GeneralSettings _self;
  final $Res Function(GeneralSettings) _then;

/// Create a copy of GeneralSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? notificationSettings = null,Object? pushNotifications = null,Object? appNotifications = null,Object? emailNotifications = null,Object? display = null,Object? language = null,Object? pushNotificationToken = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as Id,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as Id,notificationSettings: null == notificationSettings ? _self.notificationSettings : notificationSettings // ignore: cast_nullable_to_non_nullable
as List<NotificationSetting>,pushNotifications: null == pushNotifications ? _self.pushNotifications : pushNotifications // ignore: cast_nullable_to_non_nullable
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


class _GeneralSettings implements GeneralSettings {
  const _GeneralSettings({required this.id, required this.userId, required final  List<NotificationSetting> notificationSettings, this.pushNotifications = false, this.appNotifications = true, this.emailNotifications = false, this.display = 'light', this.language = 'en/English', this.pushNotificationToken}): _notificationSettings = notificationSettings;
  

@override final  Id id;
@override final  Id userId;
 final  List<NotificationSetting> _notificationSettings;
@override List<NotificationSetting> get notificationSettings {
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

/// Create a copy of GeneralSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GeneralSettingsCopyWith<_GeneralSettings> get copyWith => __$GeneralSettingsCopyWithImpl<_GeneralSettings>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GeneralSettings&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&const DeepCollectionEquality().equals(other._notificationSettings, _notificationSettings)&&(identical(other.pushNotifications, pushNotifications) || other.pushNotifications == pushNotifications)&&(identical(other.appNotifications, appNotifications) || other.appNotifications == appNotifications)&&(identical(other.emailNotifications, emailNotifications) || other.emailNotifications == emailNotifications)&&(identical(other.display, display) || other.display == display)&&(identical(other.language, language) || other.language == language)&&(identical(other.pushNotificationToken, pushNotificationToken) || other.pushNotificationToken == pushNotificationToken));
}


@override
int get hashCode => Object.hash(runtimeType,id,userId,const DeepCollectionEquality().hash(_notificationSettings),pushNotifications,appNotifications,emailNotifications,display,language,pushNotificationToken);

@override
String toString() {
  return 'GeneralSettings(id: $id, userId: $userId, notificationSettings: $notificationSettings, pushNotifications: $pushNotifications, appNotifications: $appNotifications, emailNotifications: $emailNotifications, display: $display, language: $language, pushNotificationToken: $pushNotificationToken)';
}


}

/// @nodoc
abstract mixin class _$GeneralSettingsCopyWith<$Res> implements $GeneralSettingsCopyWith<$Res> {
  factory _$GeneralSettingsCopyWith(_GeneralSettings value, $Res Function(_GeneralSettings) _then) = __$GeneralSettingsCopyWithImpl;
@override @useResult
$Res call({
 Id id, Id userId, List<NotificationSetting> notificationSettings, bool pushNotifications, bool appNotifications, bool emailNotifications, String display, String language, String? pushNotificationToken
});




}
/// @nodoc
class __$GeneralSettingsCopyWithImpl<$Res>
    implements _$GeneralSettingsCopyWith<$Res> {
  __$GeneralSettingsCopyWithImpl(this._self, this._then);

  final _GeneralSettings _self;
  final $Res Function(_GeneralSettings) _then;

/// Create a copy of GeneralSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? notificationSettings = null,Object? pushNotifications = null,Object? appNotifications = null,Object? emailNotifications = null,Object? display = null,Object? language = null,Object? pushNotificationToken = freezed,}) {
  return _then(_GeneralSettings(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as Id,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as Id,notificationSettings: null == notificationSettings ? _self._notificationSettings : notificationSettings // ignore: cast_nullable_to_non_nullable
as List<NotificationSetting>,pushNotifications: null == pushNotifications ? _self.pushNotifications : pushNotifications // ignore: cast_nullable_to_non_nullable
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
