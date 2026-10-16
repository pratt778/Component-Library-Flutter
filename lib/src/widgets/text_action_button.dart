import 'package:flutter/material.dart';

import '../theme/app_colors_extension.dart';

/// Text-only button. Height 40, no border, primary text color.
class TextActionButton extends StatelessWidget {
  const TextActionButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.leadingIcon,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? leadingIcon;

  @override
  Widget build(BuildContext context) {
    final primary = context.appColors.primary;
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: primary,
        minimumSize: const Size(0, 40),
        padding: const EdgeInsets.symmetric(horizontal: 12),
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
            Icon(leadingIcon, size: 18, color: primary),
            const SizedBox(width: 6),
          ],
          Text(label),
        ],
      ),
    );
  }
}
