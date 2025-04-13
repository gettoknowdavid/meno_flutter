import 'package:dartz/dartz.dart' show Either, Left, Right;

import 'package:intl/intl.dart' show toBeginningOfSentenceCase;
import 'package:meno_flutter/src/shared/shared.dart';

class SingleLineString extends ValueObject<String> {
  factory SingleLineString(String input) {
    final sanitizedInput = toBeginningOfSentenceCase(input.trim());
    final validationResult = _validateString(sanitizedInput);
    return SingleLineString._(validationResult);
  }

  const SingleLineString._(super.value);

  static const SingleLineString empty = SingleLineString._(Right(''));

  static Either<ValueException<String>, String> _validateString(String input) {
    if (input.isEmpty) return const Left(RequiredValueException());

    if (input.contains('\n')) {
      return Left(MaxLinesExceededValueException(input, 1));
    }

    return Right(input);
  }
}
