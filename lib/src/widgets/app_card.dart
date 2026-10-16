import 'package:flutter/material.dart';

import '../theme/app_colors_extension.dart';

/// Rounded surface card with soft drop shadow, border support, and optional tap action.
/// `hero: true` slightly increases padding (14 dp vs 12 dp).
class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    required this.child,
    this.hero = false,
    this.padding,
    this.margin,
    this.borderRadius,
    this.backgroundColor,
    this.borderColor,
    this.elevation,
    this.onTap,
    this.clip = false,
  });

  final Widget child;
  final bool hero;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? borderRadius;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? elevation;
  final VoidCallback? onTap;
  final bool clip;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final defaultPadding = EdgeInsets.all(hero ? 14 : 12);
    final radius = BorderRadius.circular(borderRadius ?? 10);

    final border = borderColor != null
        ? Border.all(color: borderColor!)
        : colors.cardBorder;

    final customShadows = elevation != null
        ? [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: elevation! * 2,
              offset: Offset(0, elevation! / 2),
            ),
          ]
        : colors.cardShadow;

    Widget content = Padding(
      padding: padding ?? defaultPadding,
      child: child,
    );

    if (onTap != null) {
      content = InkWell(
        onTap: onTap,
        borderRadius: radius,
        child: content,
      );
    }

    Widget card = Container(
      margin: margin,
      decoration: BoxDecoration(
        color: backgroundColor ?? colors.surface,
        borderRadius: radius,
        boxShadow: customShadows,
        border: border,
      ),
      clipBehavior: clip ? Clip.antiAlias : Clip.none,
      child: content,
    );

    return clip ? ClipRRect(borderRadius: radius, child: card) : card;
  }
}

/// Backward compatibility alias for [AppCard].
typedef CustomCard = AppCard;
