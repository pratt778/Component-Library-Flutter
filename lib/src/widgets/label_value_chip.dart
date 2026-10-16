import 'package:flutter/material.dart';

import '../theme/app_colors_extension.dart';

/// Inline `label value` chip for short-value summaries (counts, breakdowns,
/// etc.). Renders as a single `RichText` run — label in `onSurfaceVariant`,
/// value in `onSurface` with tabular figures so columns of digits stay
/// aligned across stacked chips.
/// Pair with `Wrap(spacing: 16, runSpacing: 6)` for a flowing layout
/// that uses horizontal space instead of stacking vertically.
class LabelValueChip extends StatelessWidget {
  const LabelValueChip({super.key, required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: '$label ',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: colors.onSurfaceVariant,
            ),
          ),
          TextSpan(
            text: value,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: colors.onSurface,
              fontFeatures: const [FontFeature.tabularFigures()],
            ),
          ),
        ],
      ),
    );
  }
}
