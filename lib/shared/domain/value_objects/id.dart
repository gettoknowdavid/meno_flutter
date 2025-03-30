import 'package:dartz/dartz.dart';
import 'package:meno_flutter/shared/domain/domain.dart';
import 'package:uuid/uuid.dart';

class Id extends ValueObject<String> {
  factory Id() => Id._(right(const Uuid().v4()));

  const Id._(this.value);

  /// Used with strings we trust are unique, such as database IDs.
  factory Id.fromString(String str) => Id._(validateRequiredValue(str));

  @override
  final Either<ValueException<String>, String> value;
}
