import 'package:flutter/material.dart';

/// Helpful extensions on [BuildContext] for responsive dimensions, theming,
/// navigation, and snackbars.
extension ContextX on BuildContext {
  /// Current screen size.
  Size get screenSize => MediaQuery.sizeOf(this);

  /// Current screen width.
  double get screenWidth => MediaQuery.sizeOf(this).width;

  /// Current screen height.
  double get screenHeight => MediaQuery.sizeOf(this).height;

  /// Current view padding (inset for notches, home indicators, status bar).
  EdgeInsets get padding => MediaQuery.paddingOf(this);

  /// Current [ThemeData].
  ThemeData get theme => Theme.of(this);

  /// Current [ColorScheme].
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  /// Current [TextTheme].
  TextTheme get textTheme => Theme.of(this).textTheme;

  /// True when the app is currently using the dark theme.
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;

  /// Shows a standard [SnackBar].
  void showSnackBar(
    String message, {
    Duration duration = const Duration(seconds: 3),
    Color? backgroundColor,
    Color? textColor,
  }) {
    ScaffoldMessenger.of(this)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            message,
            style: textColor != null ? TextStyle(color: textColor) : null,
          ),
          duration: duration,
          backgroundColor: backgroundColor,
        ),
      );
  }

  /// Pushes [page] onto the navigator.
  Future<T?> push<T>(Widget page) {
    return Navigator.of(this).push(MaterialPageRoute<T>(builder: (_) => page));
  }

  /// Replaces the current route with [page].
  Future<T?> pushReplacement<T>(Widget page) {
    return Navigator.of(this)
        .pushReplacement(MaterialPageRoute<T>(builder: (_) => page));
  }

  /// Pops the current route, optionally returning [result].
  void pop<T>([T? result]) => Navigator.of(this).pop(result);

  /// Dismisses the focused text field / keyboard.
  void unfocus() => FocusScope.of(this).unfocus();
}
