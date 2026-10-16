import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../theme/app_colors_extension.dart';
import 'app_card.dart';

/// Animated placeholder that mimics a card of list items — avatar circle +
/// two text lines + chevron per row.
///
/// Wrap in `Expanded` when used inside a `Column` with flex siblings.
class ShimmerListLoader extends StatelessWidget {
  const ShimmerListLoader({super.key, this.itemCount = 8});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return Padding(
      padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 16.0),
      child: AppCard(
        padding: EdgeInsets.zero,
        clip: true,
        child: Shimmer.fromColors(
          baseColor: colors.outlineVariant.withValues(alpha: 0.3),
          highlightColor: colors.surface,
          child: Column(
            children: List.generate(itemCount, (i) {
              return Column(
                children: [
                  _ShimmerRow(colors: colors),
                  if (i < itemCount - 1)
                    Divider(
                      height: 1,
                      thickness: 1,
                      color: colors.outlineVariant.withValues(alpha: 0.15),
                    ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}

class _ShimmerRow extends StatelessWidget {
  const _ShimmerRow({required this.colors});

  final AppColorsExtension colors;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: colors.outlineVariant,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 100,
                  height: 12,
                  decoration: BoxDecoration(
                    color: colors.outlineVariant,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  width: 160,
                  height: 10,
                  decoration: BoxDecoration(
                    color: colors.outlineVariant,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 4),
          Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              color: colors.outlineVariant,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ],
      ),
    );
  }
}
