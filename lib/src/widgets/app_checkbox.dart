import 'package:flutter/material.dart';

import '../theme/app_colors_extension.dart';

/// A theme-aware checkbox with an optional label, subtitle, and trailing widget.
///
/// When [label] (or [secondary]) is provided it renders as a tappable
/// [CheckboxListTile]; otherwise it renders as a standalone [Checkbox].
class AppCheckbox extends StatelessWidget {
  const AppCheckbox({
    super.key,
    required this.value,
    this.onChanged,
    this.label,
    this.subtitle,
    this.secondary,
    this.activeColor,
    this.checkColor,
    this.tristate = false,
    this.padding,
    this.labelStyle,
    this.dense = false,
  });

  final bool value;
  final ValueChanged<bool?>? onChanged;
  final String? label;
  final String? subtitle;
  final Widget? secondary;
  final Color? activeColor;
  final Color? checkColor;
  final bool tristate;
  final EdgeInsetsGeometry? padding;
  final TextStyle? labelStyle;
  final bool dense;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final effectiveActive = activeColor ?? colors.primary;
    final effectiveCheck = checkColor ?? colors.onPrimary;

    if (label == null && secondary == null && subtitle == null) {
      return Checkbox(
        value: value,
        onChanged: onChanged,
        activeColor: effectiveActive,
        checkColor: effectiveCheck,
        tristate: tristate,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      );
    }

    return CheckboxListTile(
      value: value,
      onChanged: onChanged,
      title: label != null
          ? Text(
              label!,
              style: labelStyle ??
                  Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: colors.onSurface,
                      ),
            )
          : null,
      subtitle: subtitle != null
          ? Text(
              subtitle!,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: colors.onSurfaceVariant,
                  ),
            )
          : null,
      secondary: secondary,
      contentPadding: padding,
      dense: dense,
      activeColor: effectiveActive,
      checkColor: effectiveCheck,
      tristate: tristate,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    );
  }
}

/// Backward compatibility alias for [AppCheckbox].
typedef CustomCheckbox = AppCheckbox;
