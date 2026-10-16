import 'package:flutter/material.dart';

import '../theme/app_colors_extension.dart';

/// A theme-aware slider with an optional label and live value readout.
class AppSlider extends StatelessWidget {
  const AppSlider({
    super.key,
    required this.value,
    this.onChanged,
    this.min = 0,
    this.max = 100,
    this.divisions,
    this.label,
    this.valueFormatter,
    this.showValue = true,
    this.activeColor,
    this.inactiveColor,
    this.prefixIcon,
    this.suffixIcon,
  });

  final double value;
  final ValueChanged<double>? onChanged;
  final double min;
  final double max;
  final int? divisions;
  final String? label;
  final String Function(double value)? valueFormatter;
  final bool showValue;
  final Color? activeColor;
  final Color? inactiveColor;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final active = activeColor ?? colors.primary;
    final inactive = inactiveColor ?? colors.outlineVariant;
    final formatted = valueFormatter?.call(value) ?? value.toStringAsFixed(0);

    return Row(
      children: [
        if (prefixIcon != null) ...[prefixIcon!, const SizedBox(width: 8)],
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (label != null || showValue)
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (label != null)
                        Text(
                          label!,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: colors.onSurface,
                              ),
                        ),
                      if (showValue)
                        Text(
                          formatted,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: active,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                    ],
                  ),
                ),
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  activeTrackColor: active,
                  inactiveTrackColor: inactive,
                  thumbColor: active,
                  overlayColor: active.withValues(alpha: 0.15),
                ),
                child: Slider(
                  value: value.clamp(min, max),
                  min: min,
                  max: max,
                  divisions: divisions,
                  onChanged: onChanged,
                ),
              ),
            ],
          ),
        ),
        if (suffixIcon != null) ...[const SizedBox(width: 8), suffixIcon!],
      ],
    );
  }
}

/// Backward compatibility alias for [AppSlider].
typedef CustomSlider = AppSlider;
