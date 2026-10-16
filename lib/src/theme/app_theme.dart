import 'package:flutter/material.dart';

import 'app_colors_extension.dart';
import 'app_typography.dart';

/// Prepares and builds a complete, themeable [ThemeData] configured with
/// [AppColorsExtension] and [AppTypography].
class AppTheme {
  const AppTheme._();

  /// Default brand seed color.
  static const Color defaultSeed = Color(0xFF2563EB);

  /// Builds a light [ThemeData] seeded with [seedColor].
  static ThemeData light({Color seedColor = defaultSeed}) {
    return fromSeed(seedColor: seedColor, brightness: Brightness.light);
  }

  /// Builds a dark [ThemeData] seeded with [seedColor].
  static ThemeData dark({Color seedColor = defaultSeed}) {
    return fromSeed(seedColor: seedColor, brightness: Brightness.dark);
  }

  /// Builds a theme configured with [AppColorsExtension] for the given [seedColor]
  /// and [brightness].
  static ThemeData fromSeed({
    required Color seedColor,
    Brightness brightness = Brightness.light,
    String? fontFamily,
  }) {
    final scheme = ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: brightness,
    );
    final isDark = brightness == Brightness.dark;
    final colorsExtension = AppColorsExtension.fromScheme(scheme);

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: scheme,
      fontFamily: fontFamily,
      textTheme: AppTypography.buildTextTheme(
        defaultColor: scheme.onSurface,
        fontFamily: fontFamily,
      ),
      scaffoldBackgroundColor: isDark
          ? colorsExtension.surfaceLow
          : scheme.surface,
      cardColor: colorsExtension.surface,
      dividerColor: colorsExtension.outlineVariant,
      extensions: [colorsExtension],
      splashFactory: InkRipple.splashFactory,
    );
  }
}
