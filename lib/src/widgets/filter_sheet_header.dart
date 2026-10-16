import 'package:flutter/material.dart';

import '../theme/app_colors_extension.dart';

/// Title row + close button for filter bottom sheets.
class FilterSheetHeader extends StatelessWidget {
  const FilterSheetHeader({
    super.key,
    required this.title,
    required this.onClose,
    this.closeTooltip,
  });

  final String title;
  final VoidCallback onClose;

  /// Tooltip for the close button. `null` (the default) renders no tooltip —
  /// pass your app's localized "Close" string if you want one.
  final String? closeTooltip;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 4, 8),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: context.appColors.onSurface,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: onClose,
            tooltip: closeTooltip,
          ),
        ],
      ),
    );
  }
}
