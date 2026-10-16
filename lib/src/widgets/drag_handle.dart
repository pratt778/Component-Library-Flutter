import 'package:flutter/material.dart';

import '../theme/app_colors_extension.dart';

/// Small horizontal pill rendered at the top of bottom-sheet content to
/// signal the drag affordance. Share it across every bottom sheet so the
/// visual stays consistent instead of duplicating a local copy per sheet.
class DragHandle extends StatelessWidget {
  const DragHandle({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 6),
      child: Container(
        width: 40,
        height: 4,
        decoration: BoxDecoration(
          color: context.appColors.outline,
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }
}
