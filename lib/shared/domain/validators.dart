import 'package:dartz/dartz.dart';
import 'package:intl/intl.dart' show toBeginningOfSentenceCase;
import 'package:meno_flutter/shared/domain/domain.dart';

Either<ValueException<String>, String> validateSingleLine(String input) {
  final formattedInput = toBeginningOfSentenceCase(input);
  if (formattedInput.contains('\n')) {
    return left(ValueException.maxLinesExceeded(input));
  }
  return right(formattedInput);
}

Either<ValueException<String>, String> validateRequiredValue(String input) {
  if (input.isEmpty) return left(const RequiredValueException());
  return right(input);
}

Either<ValueException<String>, String> validateStringLength(
  String input,
  int maxLength,
) {
  if (input.length <= maxLength) return right(input);
  return left(LengthExceededValueException(input));
}

Either<ValueException<String?>, String?> validateImageFile(String? filePath) {
  if (filePath == null || filePath.isEmpty) return right(null);

  final allowedExtensions = ['jpg', 'jpeg', 'png', 'gif'];
  final extension = filePath.split('.').last.toLowerCase();

  if (!allowedExtensions.contains(extension)) {
    return left(InvalidFileFormatException(filePath));
  }

  return right(filePath);
}
