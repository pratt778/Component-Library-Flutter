import 'package:flutter/material.dart';

import '../theme/app_colors_extension.dart';

/// A theme-aware star rating widget that is either read-only or interactive via
/// [onChanged]. Supports half-stars through [value] (e.g. 3.5 renders a half star).
class AppRating extends StatelessWidget {
  const AppRating({
    super.key,
    required this.value,
    this.onChanged,
    this.itemCount = 5,
    this.size = 24,
    this.activeColor,
    this.inactiveColor,
    this.spacing = 4,
  });

  final double value;
  final ValueChanged<double>? onChanged;
  final int itemCount;
  final double size;
  final Color? activeColor;
  final Color? inactiveColor;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final active = activeColor ?? colors.warning;
    final inactive = inactiveColor ?? colors.outline;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(itemCount, (index) {
        final starNumber = index + 1;
        final icon = onChanged != null
            ? GestureDetector(
                onTap: () => onChanged!(starNumber.toDouble()),
                child: _star(starNumber, value, size, active, inactive),
              )
            : _star(starNumber, value, size, active, inactive);
        return Padding(
          padding: EdgeInsets.only(right: index == itemCount - 1 ? 0 : spacing),
          child: icon,
        );
      }),
    );
  }

  Widget _star(
    int starNumber,
    double value,
    double size,
    Color active,
    Color inactive,
  ) {
    if (value >= starNumber) {
      return Icon(Icons.star, size: size, color: active);
    } else if (value >= starNumber - 0.5) {
      return Icon(Icons.star_half, size: size, color: active);
    }
    return Icon(Icons.star_border, size: size, color: inactive);
  }
}

/// Backward compatibility alias for [AppRating].
typedef CustomRating = AppRating;
