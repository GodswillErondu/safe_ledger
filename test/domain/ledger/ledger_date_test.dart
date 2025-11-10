import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:safe_ledger/domain/core/failures.dart';
import 'package:safe_ledger/domain/ledger/value_objects/ledger_date.dart';

void main() {
  group('LedgerDate', () {
    test('should return failure when date is in the future', () {
      final futureDate = DateTime.now().add(const Duration(days: 2));
      final result = LedgerDate(futureDate);

      expect(result.value, left(InvalidFormat(failedValue: futureDate)));
    });

    test('should return right when date is today or in the past', () {
      final today = DateTime.now();
      final pastDate = DateTime(2023, 12, 31);

      expect(LedgerDate(today).value, right(today));
      expect(LedgerDate(pastDate).value, right(pastDate));
    });

    test('should support equality and immutability', () {
      final date1 = LedgerDate(DateTime(2023, 12, 31));
      final date2 = LedgerDate(DateTime(2023, 12, 31));

      expect(date1, equals(date2));
      expect(date1.hashCode, equals(date2.hashCode));
    });

    test('getOrCrash should return the date when valid', () {
      final date = DateTime(2024, 6, 15);
      final ledgerDate = LedgerDate(date);

      expect(ledgerDate.getOrCrash(), date);
    });
  });
}
