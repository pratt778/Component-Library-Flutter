import 'package:flutter/material.dart';

import '../theme/app_colors_extension.dart';

/// Outlined secondary button. Height 44, radius 8, 1.5 dp outline border.
class SecondaryButton extends StatelessWidget {
  const SecondaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.leadingIcon,
    this.trailingIcon,
    this.color,
    this.fullWidth = false,
    this.height = 44,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? leadingIcon;
  final IconData? trailingIcon;

  /// Override text/icon color (e.g. error red for destructive outlines).
  final Color? color;
  final bool fullWidth;

  /// Compact contexts (dialogs) want less than the standard 44.
  final double height;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final fg = color ?? colors.primary;

    final btn = SizedBox(
      height: height,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: fg,
          side: BorderSide(color: colors.outline, width: 1.5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          // styleFrom bypasses theme text styles, so pull the app's font
          // family in explicitly — otherwise the label ignores the preference.
          textStyle: TextStyle(
            fontFamily: Theme.of(context).textTheme.labelLarge?.fontFamily,
            fontSize: 14,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.071 * 14,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (leadingIcon != null) ...[
              Icon(leadingIcon, size: 20, color: fg),
              const SizedBox(width: 8),
            ],
            Text(label, style: TextStyle(color: fg)),
            if (trailingIcon != null) ...[
              const SizedBox(width: 8),
              Icon(trailingIcon, size: 20, color: fg),
            ],
          ],
        ),
      ),
    );

    return fullWidth ? SizedBox(width: double.infinity, child: btn) : btn;
  }
}
