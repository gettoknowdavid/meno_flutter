import 'package:freezed_annotation/freezed_annotation.dart';

part 'password_rule.freezed.dart';

@freezed
abstract class PasswordRule with _$PasswordRule {
  const factory PasswordRule({
    required String code,
    required String message,
    required bool  isValid,
  }) = _PasswordRule;
}
