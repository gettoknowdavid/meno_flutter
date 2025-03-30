import 'package:dartz/dartz.dart';
import 'package:meno_flutter/features/auth/domain/value_objects/validators.dart';
import 'package:meno_flutter/shared/domain/domain.dart';

class Token extends ValueObject<String> {
  factory Token(String input) => Token._(validateInvalidToken(input.trim()));

  const Token._(this.value);

  @override
  final Either<ValueException<String>, String> value;
}
