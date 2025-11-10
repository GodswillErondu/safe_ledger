import 'package:safe_ledger/domain/core/failures.dart';
import 'package:uuid/uuid.dart';
import 'package:dartz/dartz.dart';
import 'package:safe_ledger/domain/core/value_objects/value_object.dart';

final _uuid = Uuid();

class UniqueId extends ValueObject<String> {
  factory UniqueId() => UniqueId._(right(_uuid.v4()));

  factory UniqueId.fromUniqueString(String uniqueIdStr) {
    return uniqueIdStr.isEmpty
        ? UniqueId._(left(EmptyValue(failedValue: uniqueIdStr)))
        : UniqueId._(right(uniqueIdStr));
  }

  const UniqueId._(this.value);

  @override
  final Either<ValueFailure<String>, String> value;
}
