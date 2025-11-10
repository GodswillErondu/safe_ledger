import 'package:flutter_test/flutter_test.dart';
import 'package:safe_ledger/domain/core/value_objects/email_address.dart';
import 'package:safe_ledger/domain/core/failures.dart';

void main() {
  group('EmailAddress ValueObject', () {
    test('should return Right for a valid email', () {
      const input = 'test@example.com';
      final email = EmailAddress(input);

      expect(email.value.isRight(), true);
      email.value.fold(
            (failure) => fail('Unexpected failure: $failure'),
            (value) => expect(value, input),
      );
    });

    test('should return Left(EmptyValue) for empty string', () {
      final emptyEmail = EmailAddress('');

      expect(emptyEmail.value.isLeft(), true);
      emptyEmail.value.fold(
            (failure) => expect(failure, isA<EmptyValue<String>>()),
            (_) => fail('Expected failure but got Right'),
      );
    });

    test('should return Left(InvalidFormat) for invalid email', () {
      final invalidEmail = EmailAddress('not-an-email');

      expect(invalidEmail.value.isLeft(), true);
      invalidEmail.value.fold(
            (failure) => expect(failure, isA<InvalidFormat<String>>()),
            (_) => fail('Expected failure but got Right'),
      );
    });

    test('should return Right for email with subdomain', () {
      const input = 'user@mail.example.com';
      final email = EmailAddress(input);

      expect(email.value.isRight(), true);
      email.value.fold(
            (failure) => fail('Unexpected failure: $failure'),
            (value) => expect(value, input),
      );
    });

    test('equality: two EmailAddress with same value are equal', () {
      final a = EmailAddress('abc@xyz.com');
      final b = EmailAddress('abc@xyz.com');

      expect(a, b);
    });

    test('inequality: two EmailAddress with different values are not equal', () {
      final a = EmailAddress('a@b.com');
      final b = EmailAddress('x@y.com');

      expect(a == b, false);
    });
  });
}
