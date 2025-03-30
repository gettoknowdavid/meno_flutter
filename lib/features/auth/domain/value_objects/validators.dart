import 'package:dartz/dartz.dart';
import 'package:meno_flutter/config/constants/password_rules.dart';
import 'package:meno_flutter/shared/domain/domain.dart';

Either<ValueException<String>, String> validateEmailAddress(String input) {
  const emailRegex =
      r"""^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+""";
  if (RegExp(emailRegex).hasMatch(input)) {
    return right(input);
  } else {
    return left(InvalidValueException(input, message: 'Invalid email address'));
  }
}

Either<ValueException<String>, String> validatePassword(String input) {
  final rules =
      passwordStrengthRules.map((r) {
        return PasswordRule(
          code: r.code,
          message: r.message,
          isValid: r.isValid(input),
        );
      }).toList();

  if (rules.every((status) => status.isValid)) {
    return right(input);
  } else {
    return left(InvalidValueException(input, message: 'Invalid password'));
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
