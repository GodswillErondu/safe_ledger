import 'package:dartz/dartz.dart';
import 'package:safe_ledger/domain/core/failures.dart';
import 'package:safe_ledger/domain/core/value_objects/value_object.dart';

class EmailAddress extends ValueObject<String> {
  static final _emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  factory EmailAddress(String input) {
    if (input.isEmpty) {
      return EmailAddress._(left(EmptyValue(failedValue: input)));
    } else if (!_emailRegex.hasMatch(input)) {
      return EmailAddress._(left(InvalidFormat(failedValue: input)));
    } else {
      return EmailAddress._(right(input));
    }
  }

  @override
  final Either<ValueFailure<String>, String> value;

  const EmailAddress._(this.value);
}
