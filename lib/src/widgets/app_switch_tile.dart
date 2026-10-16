import 'package:flutter/material.dart';

import '../theme/app_colors_extension.dart';

/// A theme-aware tile with a title, subtitle, and an adaptive [Switch].
class AppSwitchTile extends StatelessWidget {
  const AppSwitchTile({
    super.key,
    required this.value,
    this.onChanged,
    this.title,
    this.subtitle,
    this.secondary,
    this.activeColor,
    this.inactiveColor,
    this.activeThumbColor,
    this.padding,
    this.dense = false,
    this.enabled = true,
  });

  final bool value;
  final ValueChanged<bool>? onChanged;
  final String? title;
  final String? subtitle;
  final Widget? secondary;
  final Color? activeColor;
  final Color? inactiveColor;
  final Color? activeThumbColor;
  final EdgeInsetsGeometry? padding;
  final bool dense;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return SwitchListTile.adaptive(
      value: value,
      onChanged: enabled ? onChanged : null,
      title: title != null
          ? Text(
              title!,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
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
      activeColor: activeThumbColor ?? colors.onPrimary,
      activeTrackColor: activeColor ?? colors.primary,
      inactiveTrackColor: inactiveColor ?? colors.outlineVariant,
      inactiveThumbColor: activeThumbColor ?? colors.surface,
    );
  }
}

/// Backward compatibility alias for [AppSwitchTile].
typedef CustomSwitchTile = AppSwitchTile;
