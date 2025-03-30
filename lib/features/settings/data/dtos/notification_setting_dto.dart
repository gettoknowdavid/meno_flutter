import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meno_flutter/features/settings/settings.dart';

part 'notification_setting_dto.freezed.dart';
part 'notification_setting_dto.g.dart';

@freezed
abstract class NotificationSettingDto with _$NotificationSettingDto {
  const factory NotificationSettingDto({
    required String text,
    required String type,
    required bool value,
  }) = _NotificationSettingDto;

  factory NotificationSettingDto.fromJson(Map<String, dynamic> json) =>
      _$NotificationSettingDtoFromJson(json);
}

extension NotificationSettingX on NotificationSettingDto {
  NotificationSetting get toDomain {
    return NotificationSetting(text: text, type: type, value: value);
  }
}

extension NotificationSettingDtoX on NotificationSetting {
  NotificationSettingDto get toDto {
    return NotificationSettingDto(text: text, type: type, value: value);
  }
}
