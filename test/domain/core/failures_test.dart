import 'package:flutter_test/flutter_test.dart';
import 'package:safe_ledger/domain/core/failures.dart';

void main() {
  group('ValueFailure', () {
    test('EmptyValue equality and toString', () {
      const failure1 = EmptyValue(failedValue: '');
      const failure2 = EmptyValue(failedValue: '');
      const failure3 = EmptyValue(failedValue: 'something');

      expect(failure1, equals(failure2));
      expect(failure1.hashCode, equals(failure2.hashCode));
      expect(failure1, isNot(equals(failure3)));
      expect(failure1.toString(), 'EmptyValue(failedValue: )');
    });

    test('InvalidFormat equality and toString', () {
      const failure1 = InvalidFormat(failedValue: 'invalid');
      const failure2 = InvalidFormat(failedValue: 'invalid');
      const failure3 = InvalidFormat(failedValue: 'other');

      expect(failure1, equals(failure2));
      expect(failure1.hashCode, equals(failure2.hashCode));
      expect(failure1, isNot(equals(failure3)));
      expect(failure1.toString(), 'InvalidFormat(failedValue: invalid)');
    });
  });
}
