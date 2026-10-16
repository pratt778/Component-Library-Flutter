import 'package:flutter/material.dart';

import '../theme/app_colors_extension.dart';

/// A theme-aware tile for list and grid layouts.
class AppTile extends StatelessWidget {
  const AppTile({
    super.key,
    this.leading,
    this.title,
    this.subtitle,
    this.trailing,
    this.child,
    this.backgroundColor,
    this.foregroundColor,
    this.elevation = 0,
    this.borderRadius = 8,
    this.border,
    this.padding = const EdgeInsets.all(12),
    this.onTap,
  });

  final Widget? leading;
  final Widget? title;
  final Widget? subtitle;
  final Widget? trailing;
  final Widget? child;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double elevation;
  final double borderRadius;
  final BoxBorder? border;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final effectiveBg = backgroundColor ?? colors.surface;
    final effectiveFg = foregroundColor ?? colors.onSurface;
    final radius = BorderRadius.circular(borderRadius);

    Widget content = child ??
        Row(
          children: [
            if (leading != null) ...[leading!, const SizedBox(width: 12)],
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (title != null)
                    DefaultTextStyle(
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                color: effectiveFg,
                                fontWeight: FontWeight.w600,
                              ) ??
                          TextStyle(color: effectiveFg),
                      child: title!,
                    ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 2),
                    DefaultTextStyle(
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: colors.onSurfaceVariant,
                              ) ??
                          TextStyle(color: colors.onSurfaceVariant),
                      child: subtitle!,
                    ),
                  ],
                ],
              ),
            ),
            if (trailing != null) ...[const SizedBox(width: 12), trailing!],
          ],
        );

    return Material(
      color: effectiveBg,
      elevation: elevation,
      borderRadius: radius,
      child: InkWell(
        onTap: onTap,
        borderRadius: radius,
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            borderRadius: radius,
            border: border ?? Border.all(color: colors.outlineVariant),
          ),
          child: content,
        ),
      ),
    );
  }
}

/// Backward compatibility alias for [AppTile].
typedef CustomTile = AppTile;
