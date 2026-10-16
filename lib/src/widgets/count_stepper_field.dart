import 'package:flutter/material.dart';

import '../theme/app_colors_extension.dart';

/// Compact label + `−` / value / `+` stepper for "count" fields — headcounts,
/// tallies, quantities.
///
/// Sits inside a tight grid (3-up on small phones) — the whole field is
/// ~52 dp tall: 11 dp label + 4 dp gap + 32 dp stepper pill. Stepper buttons
/// are 32 dp square, the value cell flexes to fill remaining width with a
/// tabular-figures readout. No text input — count fields are tap-only so the
/// operator doesn't need to bring up the numeric keyboard to bump a tally.
class CountStepperField extends StatelessWidget {
  const CountStepperField({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
    this.min = 0,
    this.max,
  });

  final String label;
  final int value;
  final ValueChanged<int> onChanged;
  final int min;
  final int? max;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final canDecrement = value > min;
    final canIncrement = max == null || value < max!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.4,
            color: colors.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          height: 32,
          decoration: BoxDecoration(
            color: colors.surfaceLow,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              GestureDetector(
                onTap: canDecrement ? () => onChanged(value - 1) : null,
                behavior: HitTestBehavior.opaque,
                child: SizedBox(
                  width: 32,
                  height: 32,
                  child: Icon(
                    Icons.remove,
                    size: 16,
                    color: canDecrement
                        ? colors.primary
                        : colors.onSurfaceVariant.withValues(alpha: 0.4),
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    '$value',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: colors.onSurface,
                      fontFeatures: const [FontFeature.tabularFigures()],
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: canIncrement ? () => onChanged(value + 1) : null,
                behavior: HitTestBehavior.opaque,
                child: SizedBox(
                  width: 32,
                  height: 32,
                  child: Icon(
                    Icons.add,
                    size: 16,
                    color: canIncrement
                        ? colors.primary
                        : colors.onSurfaceVariant.withValues(alpha: 0.4),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
