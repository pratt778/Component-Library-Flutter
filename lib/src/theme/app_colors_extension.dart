import 'package:flutter/material.dart';

/// Semantic color tokens that flip between light and dark mode.
///
/// Access via `context.appColors.<token>`. Token names match the design
/// system tokens in `tokens.css` from the Forest Mark design handoff.
///
/// This is only the token *contract* the shared widgets read. It holds no
/// values of its own — each app builds its own instances (palette, brand
/// color, light/dark variants) and registers them in its own `ThemeData`
/// via `extensions: [...]`.
@immutable
class AppColorsExtension extends ThemeExtension<AppColorsExtension> {
  const AppColorsExtension({
    required this.primary,
    required this.primaryContainer,
    required this.onPrimary,
    required this.secondary,
    required this.surface,
    required this.surfaceLow,
    required this.onSurface,
    required this.onSurfaceVariant,
    required this.outline,
    required this.outlineVariant,
    required this.error,
    required this.success,
    required this.warning,
    required this.cardShadow,
    required this.cardBorder,
  });

  final Color primary;
  final Color primaryContainer;
  final Color onPrimary;
  final Color secondary;
  final Color surface;
  final Color surfaceLow;
  final Color onSurface;
  final Color onSurfaceVariant;
  final Color outline;
  final Color outlineVariant;
  final Color error;
  final Color success;
  final Color warning;

  /// Drop shadow for `AppCard` / dashboard tiles. Stronger in dark mode so
  /// surfaces still visually separate from the near-black background.
  final List<BoxShadow> cardShadow;

  /// Hairline border on cards. `null` in light mode (shadow is enough);
  /// 5%-white in dark mode so tiles have a visible edge against the background.
  final BoxBorder? cardBorder;

  @override
  AppColorsExtension copyWith({
    Color? primary,
    Color? primaryContainer,
    Color? onPrimary,
    Color? secondary,
    Color? surface,
    Color? surfaceLow,
    Color? onSurface,
    Color? onSurfaceVariant,
    Color? outline,
    Color? outlineVariant,
    Color? error,
    Color? success,
    Color? warning,
    List<BoxShadow>? cardShadow,
    BoxBorder? cardBorder,
  }) {
    return AppColorsExtension(
      primary: primary ?? this.primary,
      primaryContainer: primaryContainer ?? this.primaryContainer,
      onPrimary: onPrimary ?? this.onPrimary,
      secondary: secondary ?? this.secondary,
      surface: surface ?? this.surface,
      surfaceLow: surfaceLow ?? this.surfaceLow,
      onSurface: onSurface ?? this.onSurface,
      onSurfaceVariant: onSurfaceVariant ?? this.onSurfaceVariant,
      outline: outline ?? this.outline,
      outlineVariant: outlineVariant ?? this.outlineVariant,
      error: error ?? this.error,
      success: success ?? this.success,
      warning: warning ?? this.warning,
      cardShadow: cardShadow ?? this.cardShadow,
      cardBorder: cardBorder ?? this.cardBorder,
    );
  }

  @override
  AppColorsExtension lerp(ThemeExtension<AppColorsExtension>? other, double t) {
    if (other is! AppColorsExtension) return this;
    return AppColorsExtension(
      primary: Color.lerp(primary, other.primary, t)!,
      primaryContainer: Color.lerp(
        primaryContainer,
        other.primaryContainer,
        t,
      )!,
      onPrimary: Color.lerp(onPrimary, other.onPrimary, t)!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      surfaceLow: Color.lerp(surfaceLow, other.surfaceLow, t)!,
      onSurface: Color.lerp(onSurface, other.onSurface, t)!,
      onSurfaceVariant: Color.lerp(
        onSurfaceVariant,
        other.onSurfaceVariant,
        t,
      )!,
      outline: Color.lerp(outline, other.outline, t)!,
      outlineVariant: Color.lerp(outlineVariant, other.outlineVariant, t)!,
      error: Color.lerp(error, other.error, t)!,
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      // Snap shadow + border at the midpoint — interpolating shadow lists is
      // visually noisy and the swap during a theme transition is fast enough.
      cardShadow: t < 0.5 ? cardShadow : other.cardShadow,
      cardBorder: t < 0.5 ? cardBorder : other.cardBorder,
    );
  }

  factory AppColorsExtension.fromScheme(ColorScheme scheme) {
    final isDark = scheme.brightness == Brightness.dark;
    return AppColorsExtension(
      primary: scheme.primary,
      primaryContainer: scheme.primaryContainer,
      onPrimary: scheme.onPrimary,
      secondary: scheme.secondary,
      surface: scheme.surface,
      surfaceLow: isDark ? const Color(0xFF1E2124) : const Color(0xFFF9FAFB),
      onSurface: scheme.onSurface,
      onSurfaceVariant: scheme.onSurfaceVariant,
      outline: scheme.outline,
      outlineVariant: scheme.outlineVariant,
      error: scheme.error,
      success: const Color(0xFF10B981),
      warning: const Color(0xFFF59E0B),
      cardShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: isDark ? 0.35 : 0.05),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
      cardBorder: isDark ? Border.all(color: Colors.white12) : null,
    );
  }

  factory AppColorsExtension.light({Color seed = const Color(0xFF2563EB)}) {
    return AppColorsExtension.fromScheme(
      ColorScheme.fromSeed(seedColor: seed, brightness: Brightness.light),
    );
  }

  factory AppColorsExtension.dark({Color seed = const Color(0xFF2563EB)}) {
    return AppColorsExtension.fromScheme(
      ColorScheme.fromSeed(seedColor: seed, brightness: Brightness.dark),
    );
  }
}

extension AppColorsContextX on BuildContext {
  /// Safely resolves [AppColorsExtension]. Falls back to values derived from
  /// the active [ThemeData.colorScheme] if no extension is registered.
  AppColorsExtension get appColors {
    final ext = Theme.of(this).extension<AppColorsExtension>();
    if (ext != null) return ext;
    return AppColorsExtension.fromScheme(Theme.of(this).colorScheme);
  }
}
