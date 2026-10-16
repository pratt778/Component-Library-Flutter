import 'package:flutter/material.dart';

import '../theme/app_colors_extension.dart';

/// Card group label: 11 dp uppercase tracked text in `onSurfaceVariant`.
class SectionHeader extends StatelessWidget {
  const SectionHeader({super.key, required this.title, this.action});

  final String title;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final label = Text(
      title.toUpperCase(),
      style: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.06 * 11,
        color: colors.onSurfaceVariant,
      ),
    );

    if (action == null) {
      return Padding(padding: const EdgeInsets.only(bottom: 6), child: label);
    }
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [label, action!],
      ),
    );
  }
}
