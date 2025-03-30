class PasswordRuleConfig {
  const PasswordRuleConfig({
    required this.code,
    required this.message,
    required this.isValid,
  });

  final String code;
  final String message;
  final bool Function(String) isValid;
}


List<PasswordRuleConfig> passwordStrengthRules = [
  PasswordRuleConfig(
    code: 'eight-characters',
    message: 'A minimum of 8 characters',
    isValid: (String text) => RegExp('.{8,}').hasMatch(text),
  ),
  PasswordRuleConfig(
    code: 'uppercase',
    message: 'At least one uppercase letter',
    isValid: (String text) => RegExp('(?=.*[A-Z])').hasMatch(text),
  ),
  PasswordRuleConfig(
    code: 'lowercase',
    message: 'At least one lowercase letter',
    isValid: (String text) => RegExp('(?=.*[a-z])').hasMatch(text),
  ),
  PasswordRuleConfig(
    code: 'a-number',
    message: 'At least one number',
    isValid: (String text) => RegExp('(?=.*[0-9])').hasMatch(text),
  ),
  PasswordRuleConfig(
    code: 'special-character',
    message: 'At least one special character',
    isValid: (String text) => RegExp(r'(?=.*[@$!%*?&])').hasMatch(text),
  ),
];
