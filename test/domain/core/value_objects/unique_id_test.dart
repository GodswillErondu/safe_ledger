import 'package:flutter_test/flutter_test.dart';
import 'package:safe_ledger/domain/core/value_objects/unique_id.dart';
import 'package:safe_ledger/domain/core/failures.dart';
import 'package:dartz/dartz.dart';

void main() {
  group('UniqueId ValueObject', () {
    test('should generate a valid UUID when using default constructor', () {
      final id = UniqueId();

      expect(id.value.isRight(), true);
      id.value.fold(
        (failure) => fail('Should not fail: $failure'),
        (value) => expect(value.isNotEmpty, true),
      );
    });

    test('should return Right with provided non-empty string', () {
      const existingId = 'abc123';
      final id = UniqueId.fromUniqueString(existingId);

      expect(id.value, right(existingId));
    });

    test('should return Left with EmptyValue for empty string', () {
      final id = UniqueId.fromUniqueString('');

      expect(id.value.isLeft(), true);
      id.value.fold(
        (failure) => expect(failure, isA<EmptyValue<String>>()),
        (_) => fail('Expected failure but got Right'),
      );
    });

    test('equality check: two UniqueIds with same value are equal', () {
      final id1 = UniqueId.fromUniqueString('abc123');
      final id2 = UniqueId.fromUniqueString('abc123');

      expect(id1, id2);
    });

    test(
      'equality check: two UniqueIds with different values are not equal',
      () {
        final id1 = UniqueId.fromUniqueString('abc123');
        final id2 = UniqueId.fromUniqueString('xyz789');

        expect(id1 == id2, false);
      },
    );
  });
}
