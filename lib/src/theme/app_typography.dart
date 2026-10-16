import 'package:flutter/material.dart';

/// Design tokens for typography used across the component library.
///
/// Provides type scale definitions that automatically inherit the font family
/// and configuration defined in the host app's [ThemeData].
class AppTypography {
  const AppTypography._();

  /// Display Large - 52px bold
  static const TextStyle displayLarge = TextStyle(
    fontSize: 52,
    fontWeight: FontWeight.w700,
    height: 1.1,
    letterSpacing: -0.03,
  );

  /// Display Medium - 44px bold
  static const TextStyle displayMedium = TextStyle(
    fontSize: 44,
    fontWeight: FontWeight.w700,
    height: 1.1,
    letterSpacing: -0.02,
  );

  /// Display Small - 36px semibold
  static const TextStyle displaySmall = TextStyle(
    fontSize: 36,
    fontWeight: FontWeight.w600,
    height: 1.1,
    letterSpacing: -0.01,
  );

  /// Headline Large - 32px semibold
  static const TextStyle headlineLarge = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w600,
    height: 1.2,
  );

  /// Headline Medium - 28px semibold
  static const TextStyle headlineMedium = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w600,
    height: 1.2,
  );

  /// Headline Small - 24px semibold
  static const TextStyle headlineSmall = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    height: 1.2,
  );

  /// Title Large - 20px semibold
  static const TextStyle titleLarge = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    height: 1.3,
    letterSpacing: 0.005,
  );

  /// Title Medium - 16px semibold
  static const TextStyle titleMedium = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.3,
    letterSpacing: 0.01,
  );

  /// Title Small - 14px medium
  static const TextStyle titleSmall = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.3,
    letterSpacing: 0.01,
  );

  /// Body Large - 16px regular
  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );

  /// Body Medium - 14px regular
  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );

  /// Body Small - 12px regular
  static const TextStyle bodySmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );

  /// Label Large - 14px medium
  static const TextStyle labelLarge = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.2,
    letterSpacing: 0.01,
  );

  /// Label Medium - 12px medium
  static const TextStyle labelMedium = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 1.2,
    letterSpacing: 0.01,
  );

  /// Label Small - 11px medium
  static const TextStyle labelSmall = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    height: 1.2,
    letterSpacing: 0.02,
  );

  /// Builds a [TextTheme] based on these tokens, optionally applying [defaultColor]
  /// or [fontFamily].
  static TextTheme buildTextTheme({Color? defaultColor, String? fontFamily}) {
    TextStyle apply(TextStyle style) {
      TextStyle s = defaultColor != null ? style.copyWith(color: defaultColor) : style;
      return fontFamily != null ? s.copyWith(fontFamily: fontFamily) : s;
    }

    return TextTheme(
      displayLarge: apply(displayLarge),
      displayMedium: apply(displayMedium),
      displaySmall: apply(displaySmall),
      headlineLarge: apply(headlineLarge),
      headlineMedium: apply(headlineMedium),
      headlineSmall: apply(headlineSmall),
      titleLarge: apply(titleLarge),
      titleMedium: apply(titleMedium),
      titleSmall: apply(titleSmall),
      bodyLarge: apply(bodyLarge),
      bodyMedium: apply(bodyMedium),
      bodySmall: apply(bodySmall),
      labelLarge: apply(labelLarge),
      labelMedium: apply(labelMedium),
      labelSmall: apply(labelSmall),
    );
  }
}
