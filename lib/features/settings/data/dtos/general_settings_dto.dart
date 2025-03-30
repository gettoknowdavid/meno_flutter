import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meno_flutter/features/settings/settings.dart';
import 'package:meno_flutter/shared/shared.dart';

part 'general_settings_dto.freezed.dart';
part 'general_settings_dto.g.dart';

@freezed
abstract class GeneralSettingsDto with _$GeneralSettingsDto {
  const factory GeneralSettingsDto({
    required String id,
    required String userId,
    required List<NotificationSettingDto> notificationSettings,
    @Default(false) bool pushNotifications,
    @Default(true) bool appNotifications,
    @Default(false) bool emailNotifications,
    @Default('light') String display,
    @Default('en/English') String language,
    String? pushNotificationToken,
  }) = _GeneralSettingsDto;

  factory GeneralSettingsDto.fromJson(Map<String, dynamic> json) =>
      _$GeneralSettingsDtoFromJson(json);
}

extension GeneralSettingsX on GeneralSettingsDto {
  GeneralSettings get toDomain {
    return GeneralSettings(
      id: Id.fromString(id),
      userId: Id.fromString(userId),
      notificationSettings:
          notificationSettings.map((n) => n.toDomain).toList(),
      pushNotifications: pushNotifications,
      appNotifications: appNotifications,
      emailNotifications: emailNotifications,
      display: display,
      language: language,
      pushNotificationToken: pushNotificationToken,
    );
  }
}

extension GeneralSettingsDtoX on GeneralSettings {
  GeneralSettingsDto get toDto {
    return GeneralSettingsDto(
      id: id.getOrElse(''),
      userId: userId.getOrElse(''),
      notificationSettings: notificationSettings.map((n) => n.toDto).toList(),
      pushNotifications: pushNotifications,
      appNotifications: appNotifications,
      emailNotifications: emailNotifications,
      display: display,
      language: language,
      pushNotificationToken: pushNotificationToken,
    );
  }
}
