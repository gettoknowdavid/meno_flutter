import 'package:dartz/dartz.dart' show Either, Left, Right;
import 'package:meno_flutter/src/shared/shared.dart';

class MultiLineString extends ValueObject<String> {
  factory MultiLineString(String input) {
    final validationResult = _validateString(input);
    return MultiLineString._(validationResult);
  }

  const MultiLineString._(super.input);

  static const MultiLineString empty = MultiLineString._(Right(''));

  static Either<ValueException<String>, String> _validateString(String input) {
    if (input.isEmpty) return const Left(RequiredValueException());
    if (input.length > 244) return Left(LengthExceededValueException(input));
    return Right(input);
  }
}
