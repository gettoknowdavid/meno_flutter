import 'package:formz/formz.dart';

enum FullNameValidationError { empty }

class FullName extends FormzInput<String, FullNameValidationError> {
  const FullName.pure([super.value = '']) : super.pure();

  const FullName.dirty([super.value = '']) : super.dirty();

  @override
  FullNameValidationError? validator(String value) {
    if (value.isEmpty) return FullNameValidationError.empty;
    return null;
  }
}

extension FullNameValidationErrorX on FullNameValidationError {
  String get text {
    switch (this) {
      case FullNameValidationError.empty:
        return 'Full name is required';
    }
  }
}
