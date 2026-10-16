import 'package:flutter/material.dart';

import '../theme/app_colors_extension.dart';

/// A theme-aware badge that overlays a [child] with an unread count or indicator dot.
class AppNotificationBadge extends StatelessWidget {
  const AppNotificationBadge({
    super.key,
    required this.child,
    this.count,
    this.showDot = false,
    this.color,
    this.textColor,
    this.maxCount = 99,
    this.offset,
    this.padding = const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
    this.isLabelVisible = true,
  });

  final Widget child;
  final int? count;
  final bool showDot;
  final Color? color;
  final Color? textColor;
  final int maxCount;
  final Offset? offset;
  final EdgeInsets padding;
  final bool isLabelVisible;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final effectiveColor = color ?? colors.error;

    if (!isLabelVisible) return child;

    final Widget badgeContent;
    if (showDot) {
      badgeContent = Container(
        width: 8,
        height: 8,
        decoration: BoxDecoration(
          color: effectiveColor,
          shape: BoxShape.circle,
        ),
      );
    } else if (count != null && count! > 0) {
      final text = count! > maxCount ? '$maxCount+' : '$count';
      badgeContent = Container(
        padding: padding,
        decoration: BoxDecoration(
          color: effectiveColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: textColor ?? Colors.white,
            fontSize: 10,
            fontWeight: FontWeight.w600,
            height: 1.1,
          ),
        ),
      );
    } else {
      return child;
    }

    return Stack(
      clipBehavior: Clip.none,
      children: [
        child,
        Positioned(
          top: offset?.dy ?? -4,
          right: offset?.dx ?? -4,
          child: badgeContent,
        ),
      ],
    );
  }
}

/// Backward compatibility alias for [AppNotificationBadge].
typedef CustomBadge = AppNotificationBadge;
