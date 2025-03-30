import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:meno_flutter/shared/shared.dart';

abstract class IValueObject {
  bool get isValid;
}

@immutable
abstract class ValueObject<T> implements IValueObject {
  const ValueObject();

  Either<ValueException<dynamic>, Unit> get failureOrUnit {
    return value.fold(left, (r) => right(unit));
  }

  @override
  int get hashCode => value.fold((f) => f.hashCode, (r) => r.hashCode);

  @override
  bool get isValid => value.isRight();

  Either<ValueException<T>, T> get value;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ValueObject<T> && other.value == value;
  }

  T? getOrNull() => value.fold((f) => null, id);

  T getOrElse(T dflt) => value.getOrElse(() => dflt);

  @override
  String toString() => 'Value($value)';
}
