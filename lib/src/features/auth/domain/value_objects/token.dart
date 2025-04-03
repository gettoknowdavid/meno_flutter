import 'package:dartz/dartz.dart';
import 'package:meno_flutter/src/features/auth/domain/value_objects/validators.dart';
import 'package:meno_flutter/src/shared/domain/domain.dart';

class Token extends ValueObject<String> {
  factory Token(String input) => Token._(validateInvalidToken(input.trim()));

  const Token._(this.value);

  @override
  final Either<ValueException<String>, String> value;
}
