import 'package:flutter/material.dart';

import '../theme/app_colors_extension.dart';

/// Label / value pair used inside detail and summary cards.
///
/// Two layouts, chosen via [vertical]:
/// - Side-by-side (default): fixed-width label on the left, flow-then-wrap
///   value on the right. Compact defaults (12 / 13 sp text, 2 px vertical
///   padding) so a card of 4-5 rows reads as a tight block.
/// - Stacked ([vertical] = true): label above the value with a small gap
///   between them, for cards that want each field to breathe.
///
/// [dense] tightens the stacked layout for grids that put two fields on a
/// line, where the default breathing room doubles up and the card sprawls.
class LabelValueRow extends StatelessWidget {
  const LabelValueRow({
    super.key,
    required this.label,
    required this.value,
    this.labelWidth = 80,
    this.vertical = false,
    this.dense = false,
  });

  final String label;
  final String value;
  final double labelWidth;
  final bool vertical;

  /// Only affects the stacked layout.
  final bool dense;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final labelText = Text(
      label,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: dense ? 11 : 12,
        fontWeight: FontWeight.w500,
        color: colors.onSurfaceVariant,
      ),
    );
    final valueText = Text(
      value,
      textAlign: TextAlign.right,
      style: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w500,
        color: colors.onSurface,
      ),
    );

    if (vertical) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: dense ? 3 : 6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            labelText,
            SizedBox(height: dense ? 1 : 4),
            valueText,
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: labelWidth, child: labelText),
          Expanded(child: valueText),
        ],
      ),
    );
  }
}
