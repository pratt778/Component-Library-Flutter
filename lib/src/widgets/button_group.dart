import 'package:flutter/material.dart';

import '../theme/app_colors_extension.dart';

/// A button group that lets users select one option from multiple options in a
/// wrapping [Wrap] layout.
class ButtonGroup extends StatelessWidget {
  const ButtonGroup({
    super.key,
    required this.options,
    this.selected,
    this.onSelected,
    this.disabledOptions,
    this.spacing = const EdgeInsets.all(4),
    this.padding = const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
    this.borderRadius = 8,
    this.borderWidth = 1,
    this.optionTextStyle,
    this.optionWidgets,
  });

  final List<String> options;
  final String? selected;
  final ValueChanged<String>? onSelected;
  final List<String>? disabledOptions;
  final EdgeInsetsGeometry spacing;
  final EdgeInsets padding;
  final double borderRadius;
  final double borderWidth;
  final TextStyle? optionTextStyle;
  final Map<String, Widget>? optionWidgets;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: options.map((option) {
        final isSelected = option == selected;
        final isDisabled = disabledOptions?.contains(option) ?? false;
        final bg = isSelected
            ? colors.primary
            : (isDisabled ? colors.surfaceLow : colors.surface);
        final fg = isSelected
            ? colors.onPrimary
            : (isDisabled ? colors.outline : colors.onSurface);

        return Material(
          color: bg,
          borderRadius: BorderRadius.circular(borderRadius),
          child: InkWell(
            borderRadius: BorderRadius.circular(borderRadius),
            onTap: isDisabled ? null : () => onSelected?.call(option),
            child: Container(
              padding: padding,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(borderRadius),
                border: Border.all(
                  color: isSelected
                      ? colors.primary
                      : colors.outlineVariant,
                  width: borderWidth,
                ),
              ),
              child: optionWidgets?[option] ??
                  Text(
                    option,
                    style: optionTextStyle ??
                        Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: fg,
                              fontWeight: isSelected
                                  ? FontWeight.w600
                                  : FontWeight.w400,
                            ),
                  ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
