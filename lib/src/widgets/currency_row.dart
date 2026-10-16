import 'package:flutter/material.dart';

import '../theme/app_colors_extension.dart';

/// Label / value row used in billing/summary contexts — no currency
/// formatting logic inside, [value] is a pre-formatted string.
/// `total: true` renders a larger value in the primary color with bolder label.
class CurrencyRow extends StatelessWidget {
  const CurrencyRow({
    super.key,
    required this.label,
    required this.value,
    this.total = false,
    this.topDivider = true,
  });

  final String label;
  final String value;
  final bool total;
  final bool topDivider;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (topDivider)
          Divider(color: colors.outlineVariant, thickness: 1, height: 1),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: total ? 16 : 14,
                  fontWeight: total ? FontWeight.w600 : FontWeight.w400,
                  color: total ? colors.onSurface : colors.onSurfaceVariant,
                  letterSpacing: 0.018 * 14,
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: total ? 22 : 16,
                  fontWeight: total ? FontWeight.w700 : FontWeight.w500,
                  color: total ? colors.primary : colors.onSurface,
                  fontFeatures: const [FontFeature.tabularFigures()],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
