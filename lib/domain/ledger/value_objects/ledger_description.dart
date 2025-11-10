import 'package:dartz/dartz.dart';
import 'package:safe_ledger/domain/core/failures.dart';
import 'package:safe_ledger/domain/core/value_objects/value_object.dart';

class LedgerDescription extends ValueObject<String> {
  static const int maxLength = 280;

  @override
  final Either<ValueFailure<String>, String> value;

  factory LedgerDescription(String input) {
    final trimmed = input.trim();

    if (trimmed.isEmpty) {
      return LedgerDescription._(left(EmptyValue(failedValue: input)));
    } else if (trimmed.length > maxLength) {
      return LedgerDescription._(
        left(TooLong(failedValue: input, max: maxLength)),
      );
    } else {
      return LedgerDescription._(right(trimmed));
    }
  }

  const LedgerDescription._(this.value);
}
