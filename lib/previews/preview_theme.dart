import 'package:flutter/material.dart';
import 'package:component_library_flutter/component_library_flutter.dart';

/// Placeholder brand color for previews and tests. The package has no
/// `FlavorConfig` of its own — each real app owns its theme — so previews
/// need a stand-in. It has no bearing on how a consuming app looks.
const kPreviewSeed = Color(0xFF2E7D32);

/// Minimal `ThemeData` that registers an [AppColorsExtension], which is all
/// the shared widgets need to resolve `context.appColors`. A bare
/// `ThemeData.light()` does NOT work — without the extension
/// `context.appColors` null-checks and crashes.
///
/// This is intentionally NOT a full app theme (no button/input styling) —
/// real apps build their own; see the starter's `core/theme/app_theme.dart`.
ThemeData previewTheme({bool dark = false, Color seedColor = kPreviewSeed}) {
  final colors = dark
      ? AppColorsExtension(
          primary: seedColor,
          primaryContainer: const Color(0xFF2A2F28),
          onPrimary: const Color(0xFF0B1F0E),
          secondary: const Color(0xFFA4B49F),
          surface: const Color(0xFF1F2B1F),
          surfaceLow: const Color(0xFF141914),
          onSurface: const Color(0xFFE5E9E1),
          onSurfaceVariant: const Color(0xFFA4B49F),
          outline: const Color(0xFF3D453B),
          outlineVariant: const Color(0xFF2A2F28),
          error: const Color(0xFFF2B8B5),
          success: const Color(0xFF81C784),
          warning: const Color(0xFFFFB87B),
          cardShadow: const [],
          cardBorder: Border.all(color: const Color(0x0DFFFFFF)),
        )
      : AppColorsExtension(
          primary: seedColor,
          primaryContainer: const Color(0xFFC8E6C9),
          onPrimary: Colors.white,
          secondary: const Color(0xFF5D6B5A),
          surface: Colors.white,
          surfaceLow: const Color(0xFFF4F6F2),
          onSurface: const Color(0xFF1A1F1A),
          onSurfaceVariant: const Color(0xFF5D6B5A),
          outline: const Color(0xFFC7CEC4),
          outlineVariant: const Color(0xFFE5E9E1),
          error: const Color(0xFFB3261E),
          success: const Color(0xFF2E7D32),
          warning: const Color(0xFFB26A00),
          cardShadow: const [
            BoxShadow(
              color: Color(0x0F000000),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
          cardBorder: null,
        );
  return ThemeData(
    useMaterial3: true,
    brightness: dark ? Brightness.dark : Brightness.light,
    colorScheme: ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: dark ? Brightness.dark : Brightness.light,
    ),
    scaffoldBackgroundColor: colors.surfaceLow,
    extensions: <ThemeExtension<dynamic>>[colors],
  );
}
