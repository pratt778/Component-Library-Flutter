/// Spacing scale used across the component library.
///
/// Composes well with [AppRadius] and [AppDurations].
class AppSpacing {
  const AppSpacing._();

  /// 4.0
  static const double xs = 4;

  /// 8.0
  static const double sm = 8;

  /// 12.0
  static const double md = 12;

  /// 16.0
  static const double lg = 16;

  /// 24.0
  static const double xl = 24;

  /// 32.0
  static const double xxl = 32;

  /// 48.0
  static const double xxxl = 48;
}

/// Corner radius scale used across the component library.
class AppRadius {
  const AppRadius._();

  /// 4.0
  static const double sm = 4;

  /// 8.0
  static const double md = 8;

  /// 12.0
  static const double lg = 12;

  /// 16.0
  static const double xl = 16;

  /// Full rounding (pill)
  static const double full = 999;
}

/// Standard animation durations used across the component library.
class AppDurations {
  const AppDurations._();

  /// Fast transitions (hover states, small fades: 150ms).
  static const Duration fast = Duration(milliseconds: 150);

  /// Standard transitions (dialogs, sheets, menus: 250ms).
  static const Duration medium = Duration(milliseconds: 250);

  /// Slow transitions (page transitions, complex transforms: 400ms).
  static const Duration slow = Duration(milliseconds: 400);
}
