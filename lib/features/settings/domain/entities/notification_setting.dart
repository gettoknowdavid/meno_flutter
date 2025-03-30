import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_setting.freezed.dart';

@freezed
abstract class NotificationSetting with _$NotificationSetting {
  const factory NotificationSetting({
    required String text,
    required String type,
    required bool value,
  }) = _NotificationSetting;
}
