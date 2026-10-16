import 'package:flutter/material.dart';

import '../theme/app_colors_extension.dart';

/// Compact label + checkbox row. Tapping the label toggles it too.
class ToggleRow extends StatelessWidget {
  const ToggleRow({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return InkWell(
      onTap: () => onChanged(!value),
      borderRadius: BorderRadius.circular(8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: colors.onSurface,
              ),
            ),
          ),
          SizedBox(
            height: 28,
            width: 24,
            child: Checkbox.adaptive(
              value: value,
              onChanged: (val) => onChanged(val ?? false),
            ),
          ),
        ],
      ),
    );
  }
}
