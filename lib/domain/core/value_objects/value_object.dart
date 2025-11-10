import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:safe_ledger/domain/core/failures.dart';

@immutable
abstract class ValueObject<T> {
  const ValueObject();

  Either<ValueFailure<T>, T> get value;

  bool isValid() => value.isRight();

  // Extracts the value or throws an error (for debugging only)
  T getOrCrash() {
    return value.fold(
          (failure) => throw StateError(failure.toString()),
          (value) => value,
    );
  }

  Either<ValueFailure<T>, Unit> get failureOrUnit =>
      value.fold((failure) => left(failure), (_) => right(unit));

  @override
  bool operator ==(Object other) =>
    (identical(this, other)) ||
     other is ValueObject<T> && other.value == value;


  @override
  int get hashCode => value.hashCode;


  @override
  String toString() => 'Value($value)';

}