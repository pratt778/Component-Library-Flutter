import 'dart:math' as math;
import 'package:flutter/widgets.dart';

/// Helpful extensions on numeric values.
extension NumExtensions on num {
  /// Vertical spacing: `16.h` creates `SizedBox(height: 16)`.
  SizedBox get h => SizedBox(height: toDouble());

  /// Horizontal spacing: `12.w` creates `SizedBox(width: 12)`.
  SizedBox get w => SizedBox(width: toDouble());

  /// Formats the number with commas as thousand separators.
  String formatWithCommas() {
    return toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (match) => '${match[1]},',
    );
  }

  /// Rounds the number to a specified number of decimal places.
  num roundTo(int decimalPlaces) {
    final mod = math.pow(10, decimalPlaces);
    return (this * mod).round() / mod;
  }

  /// Returns the number as a percentage string (e.g. 0.5 -> "50%").
  String toPercentage([int decimalPlaces = 1]) {
    return '${(this * 100).roundTo(decimalPlaces)}%';
  }

  /// Checks if the number is between [min] and [max] (inclusive).
  bool isBetween(num min, num max) {
    return this >= min && this <= max;
  }

  /// Formats a duration in milliseconds to a human-readable string.
  String formatDuration() {
    if (this < 1000) return '${this}ms';
    if (this < 60000) return '${(this / 1000).roundTo(1)}s';
    if (this < 3600000) return '${(this / 60000).roundTo(1)}m';
    return '${(this / 3600000).roundTo(1)}h';
  }

  /// Formats bytes to a human-readable string (B, KB, MB, GB).
  String formatBytes([int decimalPlaces = 2]) {
    if (this < 1024) return '$this B';
    if (this < 1024 * 1024) return '${(this / 1024).roundTo(decimalPlaces)} KB';
    if (this < 1024 * 1024 * 1024) {
      return '${(this / (1024 * 1024)).roundTo(decimalPlaces)} MB';
    }
    return '${(this / (1024 * 1024 * 1024)).roundTo(decimalPlaces)} GB';
  }
}
