import 'package:dartz/dartz.dart';
import 'package:meno_flutter/src/shared/domain/domain.dart';

Either<ValueException<String>, String> validateEmailAddress(String input) {
  const emailRegex =
      r"""^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+""";
  if (RegExp(emailRegex).hasMatch(input)) {
    return right(input);
  } else {
    return left(InvalidValueException(input, message: 'Invalid email address'));
  }
}

Either<ValueException<String>, String> validateInvalidToken(String? input) {
  if (input == null) {
    return left(const RequiredValueException(message: 'Token is required'));
  }

  if (input.isEmpty) {
    return left(InvalidValueException(input, message: 'Invalid token'));
  }

  return right(input);
}
