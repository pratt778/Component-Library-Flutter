import 'package:flutter/material.dart';

import '../theme/app_colors_extension.dart';

/// Primary filled button. Radius 8, primary background, height 44 by default.
class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.leadingIcon,
    this.trailingIcon,
    this.isLoading = false,
    this.fullWidth = false,
    this.color,
    this.height = 44,
    this.loadingLabel,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? leadingIcon;
  final IconData? trailingIcon;
  final bool isLoading;
  final bool fullWidth;

  /// Fill override, for a primary action that is not *the* primary colour —
  /// a warning-coloured "Generate Bill", or a confirm button that has to match
  /// whichever button opened its dialog.
  final Color? color;

  /// Compact contexts (dialogs) want less than the standard 44.
  final double height;

  /// Shown beside the spinner while [isLoading].
  ///
  /// Without it the button goes wordless mid-action, which on a long request
  /// leaves the operator watching a spinner with nothing saying what it is
  /// waiting for. Null keeps the original spinner-only behaviour.
  final String? loadingLabel;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final spinner = SizedBox(
      width: isLoading && loadingLabel != null ? 16 : 20,
      height: isLoading && loadingLabel != null ? 16 : 20,
      child: CircularProgressIndicator(
        strokeWidth: 2.5,
        color: colors.onPrimary,
      ),
    );

    final content = isLoading
        ? (loadingLabel == null
              ? spinner
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    spinner,
                    const SizedBox(width: 10),
                    Flexible(
                      child: Text(
                        loadingLabel!,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.071 * 14,
                          color: colors.onPrimary,
                        ),
                      ),
                    ),
                  ],
                ))
        : Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (leadingIcon != null) ...[
                Icon(leadingIcon, size: 20, color: colors.onPrimary),
                const SizedBox(width: 8),
              ],
              Text(
                label,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.071 * 14,
                  color: colors.onPrimary,
                ),
              ),
              if (trailingIcon != null) ...[
                const SizedBox(width: 8),
                Icon(trailingIcon, size: 20, color: colors.onPrimary),
              ],
            ],
          );

    final fill = color ?? colors.primary;
    final btn = SizedBox(
      height: height,
      child: Material(
        color: onPressed == null ? fill.withValues(alpha: 0.4) : fill,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          onTap: isLoading ? null : onPressed,
          borderRadius: BorderRadius.circular(8),
          child: Center(child: content),
        ),
      ),
    );

    return fullWidth ? SizedBox(width: double.infinity, child: btn) : btn;
  }
}
