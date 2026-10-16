import 'package:flutter/material.dart';

import '../theme/app_colors_extension.dart';

/// Centered icon + message for an empty/off/error state, with an optional
/// retry button.
///
/// Unlike the app-owned version this was extracted from (`PrinterSheetMessage`
/// — renamed here since it's fully generic, nothing printer-specific about
/// it), [retryLabel] is required whenever [onRetry] is set — a shared
/// package can't read any one app's generated `AppLocalizations` class, so
/// the caller resolves its own localized "Retry" text and passes it in.
class IconMessageState extends StatelessWidget {
  const IconMessageState({
    super.key,
    required this.icon,
    required this.message,
    this.onRetry,
    this.retryLabel,
  }) : assert(
         onRetry == null || retryLabel != null,
         'retryLabel is required when onRetry is set',
       );

  final IconData icon;
  final String message;
  final VoidCallback? onRetry;
  final String? retryLabel;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 48, color: colors.onSurfaceVariant),
            const SizedBox(height: 12),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: colors.onSurfaceVariant,
                height: 1.4,
              ),
            ),
            if (onRetry != null) ...[
              const SizedBox(height: 16),
              TextButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: Text(retryLabel!),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
