import 'package:flutter/material.dart';

/// One labelled number in a stat row — e.g. Pending/Synced on a filled
/// summary card. Takes its colours in rather than a variant enum, since
/// every caller so far renders on a filled `colors.primary` card and needs
/// its own on-fill / muted pair.
class LabeledStatColumn extends StatelessWidget {
  const LabeledStatColumn({
    super.key,
    required this.label,
    required this.value,
    required this.color,
    required this.mutedColor,
  });

  final String label;
  final String value;
  final Color color;
  final Color mutedColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.06 * 10,
            color: mutedColor,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: color,
          ),
        ),
      ],
    );
  }
}
