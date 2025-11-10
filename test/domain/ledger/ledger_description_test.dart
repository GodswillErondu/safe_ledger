import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';
import 'package:safe_ledger/domain/core/failures.dart';
import 'package:safe_ledger/domain/ledger/value_objects/ledger_description.dart';

void main() {
  group('LedgerDescription', () {
    test('should return failure when input is empty', () {
      final result = LedgerDescription('');
      expect(result.value, left(const EmptyValue(failedValue: '')));
    });

    test('should return failure when input is too long', () {
      final longInput = 'a' * (LedgerDescription.maxLength + 1);
      final result = LedgerDescription(longInput);
      expect(result.value,
          left(TooLong(failedValue: longInput, max: LedgerDescription.maxLength)));
    });

    test('should return success when input is valid', () {
      const input = 'Payment for electricity bill';
      final result = LedgerDescription(input);
      expect(result.value, right(input));
    });
  });
}
