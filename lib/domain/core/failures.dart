sealed class ValueFailure<T> {
  final T failedValue;

  const ValueFailure({required this.failedValue});

  @override
  bool operator ==(Object other) =>
      (identical(this, other)) ||
          other is ValueFailure<T> && other.failedValue == failedValue;


  @override
  int get hashCode => failedValue.hashCode;
}


final class EmptyValue<T> extends ValueFailure<T> {
  const EmptyValue({required super.failedValue});

  @override
  String toString() => 'EmptyValue(failedValue: $failedValue)';
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
    return 'TooShort(failedValue: $failedValue, min: $min)';
  }
}

final class InvalidFormat<T> extends ValueFailure<T> {
  const InvalidFormat({required super.failedValue});

  @override
  String toString() => 'InvalidFormat(failedValue: $failedValue)';
}