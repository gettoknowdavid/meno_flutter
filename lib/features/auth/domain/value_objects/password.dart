import 'package:formz/formz.dart';

/// Enum representing password validation errors
enum PasswordValidationError {
  tooShort,
  missingUppercase,
  missingLowercase,
  missingNumber,
  missingSpecialCharacter,
}

/// Enum to distinguish between sign-in and sign-up modes
enum PasswordMode { login, register }

/// Represents a validated password input using Formz
class Password extends FormzInput<String, PasswordValidationError> {
  const Password.pure([super.value = '', this.mode = PasswordMode.login])
    : super.pure();

  const Password.dirty([super.value = '', this.mode = PasswordMode.login])
    : super.dirty();

  final PasswordMode mode;

  @override
  PasswordValidationError? validator(String value) {
    if (value.trim().isEmpty) return PasswordValidationError.tooShort;

    if (mode == PasswordMode.login) return null;

    if (value.length < 8) return PasswordValidationError.tooShort;

    if (!RegExp(r'(?=.*[A-Z])').hasMatch(value)) {
      return PasswordValidationError.missingUppercase;
    }
    if (!RegExp(r'(?=.*[a-z])').hasMatch(value)) {
      return PasswordValidationError.missingLowercase;
    }
    if (!RegExp(r'(?=.*[0-9])').hasMatch(value)) {
      return PasswordValidationError.missingNumber;
    }
    if (!RegExp(r'(?=.*[@$!%*?&])').hasMatch(value)) {
      return PasswordValidationError.missingSpecialCharacter;
    }

    return null;
  }

  Set<PasswordValidationError> get errors => _errors();

  Set<PasswordValidationError> _errors() {
    final e = <PasswordValidationError>{};
    if (value.length < 8) e.add(PasswordValidationError.tooShort);
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      e.add(PasswordValidationError.missingUppercase);
    }
    if (!RegExp(r'[a-z]').hasMatch(value)) {
      e.add(PasswordValidationError.missingLowercase);
    }
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      e.add(PasswordValidationError.missingNumber);
    }
    if (!RegExp(r'[@$!%*?&]').hasMatch(value)) {
      e.add(PasswordValidationError.missingSpecialCharacter);
    }

    return e;
  }
}

extension PasswordValidationErrorX on PasswordValidationError {
  String get text {
    switch (this) {
      case PasswordValidationError.missingLowercase:
        return 'Please include a lowercase letter in your password';
      case PasswordValidationError.missingNumber:
        return 'Please include a number in your password';
      case PasswordValidationError.missingSpecialCharacter:
        return 'Please include a special character in your password';
      case PasswordValidationError.missingUppercase:
        return 'Please include a uppercase letter in your password';
      case PasswordValidationError.tooShort:
        return 'Password must be atleast 8 characters';
    }
  }

  String get title {
    switch (this) {
      case PasswordValidationError.missingLowercase:
        return 'a';
      case PasswordValidationError.missingNumber:
        return '123';
      case PasswordValidationError.missingSpecialCharacter:
        return '%';
      case PasswordValidationError.missingUppercase:
        return 'A';
      case PasswordValidationError.tooShort:
        return '8+';
    }
  }

  String get subtitle {
    switch (this) {
      case PasswordValidationError.missingLowercase:
        return 'Lowercase';
      case PasswordValidationError.missingNumber:
        return 'Number';
      case PasswordValidationError.missingSpecialCharacter:
        return 'Symbol';
      case PasswordValidationError.missingUppercase:
        return 'Uppercase';
      case PasswordValidationError.tooShort:
        return 'Characters';
    }
  }
}
