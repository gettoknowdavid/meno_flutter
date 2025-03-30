import 'package:formz/formz.dart';

enum BioValidationError { maxLengthExceeded }

class Bio extends FormzInput<String?, BioValidationError> {
  const Bio.pure([super.value]) : super.pure();

  const Bio.dirty([super.value]) : super.dirty();

  @override
  BioValidationError? validator(String? value) {
    if (value == null) return null;
    if (value.length > 245) return BioValidationError.maxLengthExceeded;
    return null;
  }
}

extension BioValidationErrorX on BioValidationError {
  String get text {
    switch (this) {
      case BioValidationError.maxLengthExceeded:
        return 'Max length exceeded';
    }
  }
}
