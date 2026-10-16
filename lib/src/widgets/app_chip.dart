import 'package:flutter/material.dart';

import '../theme/app_colors_extension.dart';

/// Action chip with outlined (default) or filled variant.
///
/// [filled] renders a solid primary-coloured chip for high-emphasis actions
/// (e.g. Download, Sync in offline mode). [iconOnly] drops the label and
/// tightens padding — useful for universally-recognised icons like refresh.
class AppChip extends StatelessWidget {
  const AppChip({
    super.key,
    required this.label,
    this.icon,
    this.isLoading = false,
    this.active = false,
    this.filled = false,
    this.iconOnly = false,
    this.onTap,
  });

  final String label;
  final IconData? icon;
  final bool isLoading;
  final bool active;
  final bool filled;
  final bool iconOnly;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    final Color bg;
    final Color fg;
    final Color borderColor;

    if (filled) {
      bg = colors.primary;
      fg = colors.onPrimary;
      borderColor = colors.primary;
    } else if (active) {
      bg = colors.surface;
      fg = colors.primary;
      borderColor = colors.primary;
    } else {
      bg = colors.surface;
      fg = colors.onSurface;
      borderColor = colors.outline;
    }

    return GestureDetector(
      onTap: isLoading ? null : onTap,
      // Dimmed rather than swapped for a spinner — a chip mid-request reads
      // as "disabled for a moment", and a spinner on every small chip is
      // more animation than this many-chips-per-screen UI needs.
      child: Opacity(
        opacity: isLoading ? 0.45 : 1,
        child: Container(
          height: 32,
          padding: EdgeInsets.symmetric(horizontal: iconOnly ? 8 : 10),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: borderColor, width: 1.5),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(
                  icon,
                  size: 16,
                  color: filled ? fg : colors.onSurfaceVariant,
                ),
                if (!iconOnly) const SizedBox(width: 5),
              ],
              if (!iconOnly)
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: fg,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
