import 'package:dartz/dartz.dart';
import 'package:safe_ledger/domain/core/failures.dart';
import 'package:safe_ledger/domain/core/value_objects/value_object.dart';

class NonEmptyString extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;
  factory NonEmptyString(String input) {
    final trimmed = input.trim();

    if (trimmed.isEmpty) {
      return NonEmptyString._(
        left(EmptyValue(failedValue: input)),
      );
    } else {
      return NonEmptyString._(
        right(trimmed),
      );
    }
  }
  const NonEmptyString._(this.value);

}