import 'package:flutter/material.dart';

import '../theme/app_colors_extension.dart';

/// A theme-aware alert dialog customizable with a title, content widget, and actions.
class AppAlertDialog extends StatelessWidget {
  const AppAlertDialog({
    super.key,
    this.title,
    this.content,
    this.actions,
    this.barrierDismissible = true,
    this.borderRadius = 16,
    this.padding = const EdgeInsets.all(24),
  });

  final String? title;
  final Widget? content;
  final List<Widget>? actions;
  final bool barrierDismissible;
  final double borderRadius;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Dialog(
      backgroundColor: colors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Padding(
        padding: padding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title != null) ...[
              Text(
                title!,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: colors.onSurface,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: 12),
            ],
            if (content != null) ...[
              content!,
              const SizedBox(height: 16),
            ],
            if (actions != null && actions!.isNotEmpty)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: actions!,
              ),
          ],
        ),
      ),
    );
  }

  /// Shows the dialog and returns the future value from `Navigator.pop`.
  static Future<T?> show<T>(
    BuildContext context, {
    String? title,
    Widget? content,
    List<Widget>? actions,
    bool barrierDismissible = true,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) => AppAlertDialog(
        title: title,
        content: content,
        actions: actions,
        barrierDismissible: barrierDismissible,
      ),
    );
  }
}

/// Backward compatibility alias for [AppAlertDialog].
typedef CustomAlertDialog = AppAlertDialog;
