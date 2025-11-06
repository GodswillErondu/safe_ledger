sealed class ValueFailure<T> {
  final T failedValue;

  const ValueFailure({required this.failedValue});
}


final class Empty<T> extends ValueFailure<T> {
  Empty({required super.failedValue});

  @override
  String toString() {
    return 'Empty(failedValue: $failedValue';
  }
}

final class TooLong<T> extends ValueFailure<T> {
  final int max;

  const TooLong({required super.failedValue, required this.max});

  @override
  String toString() {
    return 'TooLong(failedValue: $failedValue, max: $max)';
  }
}

final class TooShort<T> extends ValueFailure<T> {
  final int min;

  const TooShort({required super.failedValue, required this.min});

  @override
  String toString() {
    return 'TooShort(failedValue: $failedValue, max: $min)';
  }
}


