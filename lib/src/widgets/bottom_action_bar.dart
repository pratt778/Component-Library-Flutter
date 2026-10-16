import 'package:flutter/material.dart';

import '../theme/app_colors_extension.dart';

/// Sticky bottom bar used on billing and ticket-style screens.
///
/// Shows an optional total row (label + formatted amount) above an action row
/// containing one or two full-width buttons. Pass children in [actions].
class BottomActionBar extends StatelessWidget {
  const BottomActionBar({
    super.key,
    required this.actions,
    this.totalLabel,
    this.totalValue,
    this.extraContent,
  });

  /// Widgets placed in a [Row] below the total row. Wrap buttons in [Expanded]
  /// if you want them to share the available width equally.
  final List<Widget> actions;

  /// e.g. "Total" or "Total · 4 pax"
  final String? totalLabel;

  /// e.g. "Rs. 8,850.00"
  final String? totalValue;

  /// Optional widget rendered between the total row and the action row.
  final Widget? extraContent;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final hasTotalRow = totalLabel != null && totalValue != null;

    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          color: colors.surface,
          border: Border(top: BorderSide(color: colors.outlineVariant)),
        ),
        padding: const EdgeInsets.fromLTRB(14, 10, 14, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (hasTotalRow) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    totalLabel!,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: colors.onSurfaceVariant,
                    ),
                  ),
                  Text(
                    totalValue!,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: colors.primary,
                      fontFeatures: const [FontFeature.tabularFigures()],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
            ],
            if (extraContent != null) ...[
              extraContent!,
              const SizedBox(height: 8),
            ],
            Row(
              children: actions
                  .expand(
                    (w) => [w, if (w != actions.last) const SizedBox(width: 8)],
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
