import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../theme/app_colors_extension.dart';

/// A single animated placeholder rectangle.
///
/// Use directly for custom shimmer layouts, or reach for
/// [ShimmerListLoader] for the common list-item pattern.
class ShimmerBox extends StatelessWidget {
  const ShimmerBox({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius = 6,
  });

  final double width;
  final double height;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return Shimmer.fromColors(
      baseColor: colors.outlineVariant.withValues(alpha: 0.3),
      highlightColor: colors.surface,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: colors.outlineVariant,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}
