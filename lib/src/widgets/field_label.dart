import 'package:flutter/material.dart';

import '../theme/app_colors_extension.dart';

/// Required-field label: text + a red `*`.
class FieldLabel extends StatelessWidget {
  final String text;

  const FieldLabel({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0),
      child: RichText(
        text: TextSpan(
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: context.appColors.onSurface,
          ),
          children: [
            TextSpan(text: '$text '),
            TextSpan(
              text: '*',
              style: Theme.of(context).textTheme.bodyMedium
                  ?.copyWith(fontSize: 14, color: context.appColors.error),
            ),
          ],
        ),
      ),
    );
  }
}
