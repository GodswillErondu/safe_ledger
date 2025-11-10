import 'package:flutter_test/flutter_test.dart';
import 'package:safe_ledger/domain/core/value_objects/non_empty_string.dart';
import 'package:safe_ledger/domain/core/failures.dart';

void main() {
  group('NonEmptyString ValueObject', () {
    test('should return Right for a valid non-empty string', () {
      const input = 'Hello World';
      final nonEmpty = NonEmptyString(input);

      expect(nonEmpty.value.isRight(), true);
      nonEmpty.value.fold(
            (failure) => fail('Unexpected failure: $failure'),
            (value) => expect(value, input),
      );
    });

    test('should trim input before returning Right', () {
      const input = '  padded text  ';
      final nonEmpty = NonEmptyString(input);

      nonEmpty.value.fold(
            (failure) => fail('Unexpected failure: $failure'),
            (value) => expect(value, 'padded text'),
      );
    });

    test('should return Left(EmptyValue) for empty string', () {
      final empty = NonEmptyString('');

      expect(empty.value.isLeft(), true);
      empty.value.fold(
            (failure) => expect(failure, isA<EmptyValue<String>>()),
            (_) => fail('Expected failure but got Right'),
      );
    });

    test('should return Left(EmptyValue) for whitespace-only string', () {
      final whitespace = NonEmptyString('   ');

      expect(whitespace.value.isLeft(), true);
      whitespace.value.fold(
            (failure) => expect(failure, isA<EmptyValue<String>>()),
            (_) => fail('Expected failure but got Right'),
      );
    });

    test('equality: two NonEmptyStrings with same value are equal', () {
      final a = NonEmptyString('Test');
      final b = NonEmptyString('Test');

      expect(a, b);
    });

    test('inequality: two NonEmptyStrings with different values are not equal', () {
      final a = NonEmptyString('Test');
      final b = NonEmptyString('Different');

      expect(a == b, false);
    });
  });
}
