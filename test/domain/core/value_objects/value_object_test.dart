import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:safe_ledger/domain/core/failures.dart';
import 'package:safe_ledger/domain/core/value_objects/value_object.dart';

class TestValue extends ValueObject<String> {
  const TestValue._(this.value);

  @override
  final Either<ValueFailure<String>, String> value;

  factory TestValue.valid(String input) => TestValue._(right(input));

  factory TestValue.invalid(String input) =>
      TestValue._(left(InvalidFormat(failedValue: input)));
}

void main() {
  group('ValueObject', () {
    test('should return true when value is valid (Right)', () {
      final sut = TestValue.valid('hello');
      expect(sut.isValid(), true);
    });

    test('should return false when value is invalid (Left)', () {
      final sut = TestValue.invalid('bad');
      expect(sut.isValid(), false);
    });

    test('should compare equality correctly', () {
      final sut1 = TestValue.valid('same');
      final sut2 = TestValue.valid('same');
      final sut3 = TestValue.valid('different');

      expect(sut1, equals(sut2));
      expect(sut1, isNot(equals(sut3)));
    });

    test('should return the correct failureOrUnit result', () {
      final valid = TestValue.valid('ok');
      final invalid = TestValue.invalid('nope');

      expect(valid.failureOrUnit.isRight(), true);
      expect(invalid.failureOrUnit.isLeft(), true);
    });
  });
}
