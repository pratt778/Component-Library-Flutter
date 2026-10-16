import 'package:flutter/material.dart';

import '../theme/app_colors_extension.dart';

/// One option row inside [PickerSheet] — a rounded, tappable row showing the
/// English label (with the Nepali label beneath, when present). The selected
/// option gets a primary-tinted background and a filled check badge, plus a
/// clear button right beside it when [onClear] is set.
class PickerOptionTile extends StatelessWidget {
  const PickerOptionTile({
    super.key,
    required this.labelEn,
    required this.labelNp,
    required this.isSelected,
    required this.onTap,
    this.onClear,
    this.clearTooltip,
  });

  final String labelEn;
  final String labelNp;
  final bool isSelected;
  final VoidCallback onTap;

  /// Unselects this option. Only rendered when [isSelected] is also true —
  /// there's nothing to clear on an unselected row.
  final VoidCallback? onClear;

  /// Tooltip for the clear button. `null` (the default) renders no tooltip —
  /// pass your app's localized "Clear" string if you want one.
  final String? clearTooltip;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return Material(
      color: isSelected
          ? colors.primary.withValues(alpha: 0.10)
          : Colors.transparent,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.circle,
                          size: 8,
                          color: isSelected
                              ? colors.primary
                              : colors.onSurfaceVariant,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          labelEn,
                          style: TextStyle(
                            fontSize: 14.5,
                            fontWeight: isSelected
                                ? FontWeight.w600
                                : FontWeight.w500,
                            color: isSelected
                                ? colors.primary
                                : colors.onSurface,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              if (isSelected) ...[
                if (onClear != null)
                  IconButton(
                    tooltip: clearTooltip,
                    icon: Icon(
                      Icons.cancel,
                      size: 18,
                      color: colors.onSurfaceVariant,
                    ),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    visualDensity: VisualDensity.compact,
                    onPressed: onClear,
                  ),
                const SizedBox(width: 8),
                Container(
                  width: 20,
                  height: 20,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: colors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.check, size: 14, color: colors.onPrimary),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
