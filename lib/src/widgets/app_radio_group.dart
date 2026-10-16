import 'package:flutter/material.dart';

import '../theme/app_colors_extension.dart';

/// A theme-aware radio group rendered as a list of selectable tiles.
class AppRadioGroup<T> extends StatelessWidget {
  const AppRadioGroup({
    super.key,
    required this.options,
    this.value,
    this.onChanged,
    required this.labelBuilder,
    this.subtitleBuilder,
    this.activeColor,
    this.padding,
    this.dense = false,
  });

  final List<T> options;
  final T? value;
  final ValueChanged<T?>? onChanged;
  final String Function(T option) labelBuilder;
  final String Function(T option)? subtitleBuilder;
  final Color? activeColor;
  final EdgeInsetsGeometry? padding;
  final bool dense;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final active = activeColor ?? colors.primary;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: options.map((option) {
        final isSelected = value == option;
        return RadioListTile<T>(
          value: option,
          groupValue: value,
          onChanged: onChanged,
          activeColor: active,
          dense: dense,
          contentPadding: padding,
          title: Text(
            labelBuilder(option),
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: colors.onSurface,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                ),
          ),
          subtitle: subtitleBuilder != null
              ? Text(
                  subtitleBuilder!(option),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: colors.onSurfaceVariant,
                      ),
                )
              : null,
          controlAffinity: ListTileControlAffinity.leading,
        );
      }).toList(),
    );
  }
}

/// Backward compatibility alias for [AppRadioGroup].
typedef CustomRadioGroup<T> = AppRadioGroup<T>;
