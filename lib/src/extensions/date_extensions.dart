/// Convenience helpers for working with [DateTime] values.
extension DateTimeX on DateTime {
  /// True if the date is today.
  bool get isToday {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }

  /// True if the date was yesterday.
  bool get isYesterday {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return year == yesterday.year &&
        month == yesterday.month &&
        day == yesterday.day;
  }

  /// True if the date is tomorrow.
  bool get isTomorrow {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return year == tomorrow.year &&
        month == tomorrow.month &&
        day == tomorrow.day;
  }

  /// Compares year, month, and day equality.
  bool isSameDate(DateTime other) =>
      year == other.year && month == other.month && day == other.day;

  /// Compares whether this date is before [other] ignoring time components.
  bool isBeforeDate(DateTime other) =>
      !isSameDate(other) && isBefore(other);

  /// Compares whether this date is after [other] ignoring time components.
  bool isAfterDate(DateTime other) =>
      !isSameDate(other) && isAfter(other);

  /// Start of the day (midnight 00:00:00).
  DateTime get startOfDay => DateTime(year, month, day);

  /// Last millisecond of the day (23:59:59.999).
  DateTime get endOfDay => DateTime(year, month, day, 23, 59, 59, 999);

  /// First day of the month.
  DateTime get startOfMonth => DateTime(year, month, 1);

  /// Last day of the month.
  DateTime get endOfMonth => DateTime(year, month + 1, 0, 23, 59, 59, 999);

  /// Returns a copy with any number of fields overridden.
  DateTime copyWith({
    int? year,
    int? month,
    int? day,
    int? hour,
    int? minute,
    int? second,
    int? millisecond,
  }) {
    return DateTime(
      year ?? this.year,
      month ?? this.month,
      day ?? this.day,
      hour ?? this.hour,
      minute ?? this.minute,
      second ?? this.second,
      millisecond ?? this.millisecond,
    );
  }

  /// Adds [months] months, clamping the day to the valid range of the target month.
  DateTime addMonths(int months) {
    final firstOfTarget = DateTime(year, month + months, 1);
    final lastDay = DateTime(firstOfTarget.year, firstOfTarget.month + 1, 0).day;
    final safeDay = day > lastDay ? lastDay : day;
    return DateTime(
      firstOfTarget.year,
      firstOfTarget.month,
      safeDay,
      hour,
      minute,
      second,
      millisecond,
    );
  }

  /// Adds [years] years, clamping the day to the valid range.
  DateTime addYears(int years) => addMonths(years * 12);

  /// Adds [days] days.
  DateTime addDays(int days) => add(Duration(days: days));

  /// Human-friendly relative label: Today / Yesterday / Tomorrow / dd MMM yyyy.
  String toRelativeLabel({List<String>? months}) {
    if (isToday) return 'Today';
    if (isYesterday) return 'Yesterday';
    if (isTomorrow) return 'Tomorrow';
    const names = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];
    return '$day ${(months ?? names)[month - 1]} $year';
  }
}
