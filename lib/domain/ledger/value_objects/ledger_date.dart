import 'package:dartz/dartz.dart';
import 'package:safe_ledger/domain/core/failures.dart';
import 'package:safe_ledger/domain/core/value_objects/value_object.dart';

class LedgerDate extends ValueObject<DateTime> {
  @override
  final Either<ValueFailure<DateTime>, DateTime> value;

  factory LedgerDate(DateTime input) {
    final now = DateTime.now();

    if (input.isAfter(now)) {
      return LedgerDate._(
        left(InvalidFormat(failedValue: input)),
      );
    } else {
      return LedgerDate._(right(input));
    }
  }

  const LedgerDate._(this.value);
}


