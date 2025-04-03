import 'package:equatable/equatable.dart';

final class NotificationSetting with EquatableMixin {
  NotificationSetting({
    required this.text,
    required this.type,
    required this.value,
  });

  final String text;
  final String type;
  final bool value;

  @override
  List<Object?> get props => [text, type, value];
  NotificationSetting copyWith({String? text, String? type, bool? value}) {
    return NotificationSetting(
      text: text ?? this.text,
      type: type ?? this.type,
      value: value ?? this.value,
    );
  }
}
