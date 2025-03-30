import 'package:freezed_annotation/freezed_annotation.dart';

part 'value_exception.freezed.dart';

@freezed
abstract class ValueException<T> with _$ValueException<T> implements Exception {
  const factory ValueException.required({
    @Default('required-value') String code,
    @Default('This value cannot be empty.') String message,
  }) = RequiredValueException<T>;
  const factory ValueException.invalid(
    T invalidValue, {
    @Default('invalid-value') String code,
    @Default('Invalid value.') String message,
  }) = InvalidValueException<T>;
  const factory ValueException.lengthExceeded(
    T invalidValue, {
    @Default('length-exceeded') String code,
    @Default('Value length has been exceeded.') String message,
  }) = LengthExceededValueException<T>;
  const factory ValueException.maxLinesExceeded(
    T invalidValue, {
    @Default('max-lines-exceeded') String code,
    @Default('Number of valid lines has been exceeded.') String message,
  }) = MaxLinesExceededValueException<T>;
  const factory ValueException.invalidFormat(
    T invalidValue, {
    @Default('invalid-format') String code,
    @Default('The file format selected is invalid.') String message,
  }) = InvalidFileFormatException<T>;
}
