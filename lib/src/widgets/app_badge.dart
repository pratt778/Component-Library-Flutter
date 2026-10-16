import 'package:flutter/material.dart';

import '../theme/app_colors_extension.dart';

enum AppBadgeVariant { success, warning, info, error }

/// Small status badge pill (success / warning / info).
class AppBadge extends StatelessWidget {
  const AppBadge({
    super.key,
    required this.label,
    this.variant = AppBadgeVariant.info,
  });

  final String label;
  final AppBadgeVariant variant;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    final Color fg;
    final Color bg;
    switch (variant) {
      case AppBadgeVariant.success:
        fg = colors.success;
        bg = colors.success.withValues(alpha: 0.18);
      case AppBadgeVariant.warning:
        fg = colors.warning;
        bg = colors.warning.withValues(alpha: 0.18);
      case AppBadgeVariant.info:
        fg = colors.primary;
        bg = colors.primaryContainer;
      case AppBadgeVariant.error:
        fg = colors.error;
        bg = colors.error.withValues(alpha: 0.18);
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label.toUpperCase(),
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.05 * 11,
          color: fg,
        ),
      ),
    );
  }
}
