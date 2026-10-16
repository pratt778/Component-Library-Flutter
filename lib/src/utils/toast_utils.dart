import 'package:flutter/material.dart';

/// Utilities to show lightweight, themeable toast notifications using [ScaffoldMessenger].
class ToastUtils {
  ToastUtils._();

  /// Shows a themed toast/snackbar with an optional icon.
  static void show(
    BuildContext context, {
    required String message,
    IconData? icon,
    Color? backgroundColor,
    Color? textColor,
    Duration duration = const Duration(seconds: 3),
    SnackBarBehavior behavior = SnackBarBehavior.floating,
  }) {
    final messenger = ScaffoldMessenger.of(context);
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Row(
            children: [
              if (icon != null) ...[
                Icon(icon, color: textColor ?? Colors.white, size: 20),
                const SizedBox(width: 12),
              ],
              Expanded(
                child: Text(
                  message,
                  style: TextStyle(color: textColor ?? Colors.white),
                ),
              ),
            ],
          ),
          behavior: behavior,
          duration: duration,
          backgroundColor: backgroundColor,
        ),
      );
  }

  /// Shows a success toast.
  static void success(
    BuildContext context,
    String message, {
    Duration? duration,
  }) {
    show(
      context,
      message: message,
      icon: Icons.check_circle,
      backgroundColor: const Color(0xFF10B981),
      duration: duration ?? const Duration(seconds: 3),
    );
  }

  /// Shows an error toast.
  static void error(
    BuildContext context,
    String message, {
    Duration? duration,
  }) {
    show(
      context,
      message: message,
      icon: Icons.error,
      backgroundColor: const Color(0xFFEF4444),
      duration: duration ?? const Duration(seconds: 3),
    );
  }

  /// Shows an info toast.
  static void info(
    BuildContext context,
    String message, {
    Duration? duration,
  }) {
    show(
      context,
      message: message,
      icon: Icons.info_outline,
      backgroundColor: const Color(0xFF2563EB),
      duration: duration ?? const Duration(seconds: 3),
    );
  }

  /// Shows a warning toast.
  static void warning(
    BuildContext context,
    String message, {
    Duration? duration,
  }) {
    show(
      context,
      message: message,
      icon: Icons.warning_amber,
      backgroundColor: const Color(0xFFF59E0B),
      duration: duration ?? const Duration(seconds: 3),
    );
  }
}
