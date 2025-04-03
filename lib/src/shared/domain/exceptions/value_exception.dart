sealed class ValueException<T> implements Exception {
  const ValueException({required this.code, required this.message});

  final String code;
  final String message;
}

final class RequiredValueException<T> extends ValueException<T> {
  const RequiredValueException({
    super.code = 'required-value',
    super.message = 'This value cannot be empty.',
  });
}

final class InvalidValueException<T> extends ValueException<T> {
  const InvalidValueException(
    this.value, {
    super.code = 'invalid-value',
    super.message = 'Invalid value.',
  });

  final T value;
}

final class LengthExceededValueException<T> extends ValueException<T> {
  const LengthExceededValueException(
    this.value, {
    super.code = 'length-exceeded',
    super.message = 'Value length has been exceeded.',
  });

  final T value;
}

final class MaxLinesExceededValueException<T> extends ValueException<T> {
  const MaxLinesExceededValueException(
    this.value, {
    super.code = 'max-lines-exceeded',
    super.message = 'Number of valid lines has been exceeded.',
  });

  final T value;
}

final class InvalidFileFormatException<T> extends ValueException<T> {
  const InvalidFileFormatException(
    this.value, {
    super.code = 'invalid-format',
    super.message = 'The file format selected is invalid.',
  });

  final T value;
}
