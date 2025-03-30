import 'package:formz/formz.dart';

enum CheckboxValidationError { required }

class CheckboxField extends FormzInput<bool?, CheckboxValidationError> {
  const CheckboxField.pure([super.value = false]) : super.pure();
  const CheckboxField.dirty([super.value = false]) : super.dirty();

  @override
  CheckboxValidationError? validator(bool? value) {
    if (value ?? false) return null;
    return CheckboxValidationError.required;
  }
}

extension CheckboxValidationX on CheckboxValidationError {
  String get text => switch (this) {
    CheckboxValidationError.required => 'Please accept the Terms of Service',
  };
}
