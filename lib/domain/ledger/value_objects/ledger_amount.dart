import 'package:dartz/dartz.dart';
import 'package:safe_ledger/domain/core/failures.dart';
import 'package:safe_ledger/domain/core/value_objects/value_object.dart';

class LedgerAmount extends ValueObject<num> {
  @override
  final Either<ValueFailure<num>, num> value;

  factory LedgerAmount(num input) {
    if (input <= 0) {
      return LedgerAmount._(
        left(InvalidFormat(failedValue: input)),
      );
    } else {
      return LedgerAmount._(right(input));
    }
  }

  const LedgerAmount._(this.value);
}
