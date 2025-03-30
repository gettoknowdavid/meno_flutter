import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meno_flutter/features/settings/domain/entities/notification_setting.dart';
import 'package:meno_flutter/shared/shared.dart';

part 'general_settings.freezed.dart';

@freezed
abstract class GeneralSettings with _$GeneralSettings {
  const factory GeneralSettings({
    required Id id,
    required Id userId,
    required List<NotificationSetting> notificationSettings,
    @Default(false) bool pushNotifications,
    @Default(true) bool appNotifications,
    @Default(false) bool emailNotifications,
    @Default('light') String display,
    @Default('en/English') String language,
    String? pushNotificationToken,
  }) = _GeneralSettings;
}
