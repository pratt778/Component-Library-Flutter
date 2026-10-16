import 'package:flutter/material.dart';

import '../theme/app_colors_extension.dart';

enum AppProgressType { circular, linear }

/// A theme-aware progress indicator supporting both circular and linear modes.
class AppProgressIndicator extends StatelessWidget {
  const AppProgressIndicator({
    super.key,
    this.value,
    this.type = AppProgressType.circular,
    this.color,
    this.backgroundColor,
    this.size = 36,
    this.strokeWidth = 3.5,
  });

  final double? value;
  final AppProgressType type;
  final Color? color;
  final Color? backgroundColor;
  final double size;
  final double strokeWidth;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final fg = color ?? colors.primary;
    final bg = backgroundColor ?? fg.withValues(alpha: 0.15);

    if (type == AppProgressType.linear) {
      return LinearProgressIndicator(
        value: value,
        color: fg,
        backgroundColor: bg,
        minHeight: strokeWidth,
        borderRadius: BorderRadius.circular(strokeWidth),
      );
    }

    return SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        value: value,
        strokeWidth: strokeWidth,
        color: fg,
        backgroundColor: bg,
      ),
    );
  }
}

/// Backward compatibility alias for [AppProgressIndicator].
typedef CustomProgressIndicator = AppProgressIndicator;
