import 'package:dartz/dartz.dart' show Either, Left, Right;
import 'package:meno_flutter/src/shared/shared.dart';

class TermsCheckbox extends ValueObject<bool> {
  factory TermsCheckbox(bool input) {
    final validationResult = _validateBool(input);
    return TermsCheckbox._(validationResult);
  }

  const TermsCheckbox._(super.input);

  static const TermsCheckbox emptyAsFalse = TermsCheckbox._(Right(false));

  static Either<ValueException<bool>, bool> _validateBool(bool input) {
    if (!input) {
      return const Left(
        RequiredValueException(message: 'Please accept the Terms of Service'),
      );
    }

    return Right(input);
  }
}
