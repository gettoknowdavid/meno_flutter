import 'package:formz/formz.dart';
import 'package:intl/intl.dart';

enum SingleLineError { maxLineExceeded }

class SingleLineString extends FormzInput<String, SingleLineError> {
  const SingleLineString.pure([super.value = '']) : super.pure();

  const SingleLineString.dirty([super.value = '']) : super.dirty();

  @override
  SingleLineError? validator(String value) {
    final formattedInput = toBeginningOfSentenceCase(value);
    if (formattedInput.contains('\n')) return SingleLineError.maxLineExceeded;
    return null;
  }
}

extension SingleLineErrorX on SingleLineError {
  String get text {
    switch (this) {
      case SingleLineError.maxLineExceeded:
        return 'Number of valid lines has been exceeded.';
    }
  }
}
