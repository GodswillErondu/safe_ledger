import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:safe_ledger/domain/core/failures.dart';
import 'package:safe_ledger/domain/ledger/value_objects/ledger_amount.dart';

void main() {
  group('LedgerAmount', () {
    test('should return failure when amount is zero', () {
      final result = LedgerAmount(0);
      expect(result.value, left(const InvalidFormat(failedValue: 0)));
    });

    test('should return failure when amount is negative', () {
      final result = LedgerAmount(-100);
      expect(result.value, left(const InvalidFormat(failedValue: -100)));
    });

    test('should return right when amount is positive', () {
      final result = LedgerAmount(2500);
      expect(result.value, right(2500));
    });

    test('should support equality and immutability', () {
      final amount1 = LedgerAmount(1000);
      final amount2 = LedgerAmount(1000);

      expect(amount1, equals(amount2));
      expect(amount1.hashCode, equals(amount2.hashCode));
    });

    test('getOrCrash should return valid number when successful', () {
      final amount = LedgerAmount(500);
      expect(amount.getOrCrash(), 500);
    });
  });
}
