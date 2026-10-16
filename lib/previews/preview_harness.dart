import 'package:flutter/material.dart';

import 'preview_theme.dart';

/// Wraps [child] in a `MaterialApp` using [previewTheme], so
/// `context.appColors` resolves correctly inside previews (a bare
/// `ThemeData.light()` has no `AppColorsExtension` and would crash).
Widget previewApp(Widget child, {bool dark = false}) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: previewTheme(dark: dark),
    home: Scaffold(body: child),
  );
}

/// Same as [previewApp], but centers [child] with some breathing room —
/// the common case for a single small widget (a button, a chip, a card).
Widget previewCentered(Widget child, {bool dark = false}) {
  return previewApp(
    Padding(
      padding: const EdgeInsets.all(24),
      child: Center(child: child),
    ),
    dark: dark,
  );
}
