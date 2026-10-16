import 'package:flutter/material.dart';

import 'primary_button.dart';
import 'secondary_button.dart';

/// Reset + Search buttons at the bottom of any filter bottom sheet.
///
/// Unlike the app-owned version this was extracted from, [resetLabel] /
/// [searchLabel] are required — a shared package can't read any one app's
/// generated `AppLocalizations` class, so the caller resolves its own
/// localized button text and passes it in.
class FilterSheetActionRow extends StatelessWidget {
  const FilterSheetActionRow({
    super.key,
    required this.onReset,
    required this.onSearch,
    required this.resetLabel,
    required this.searchLabel,
  });

  final VoidCallback onReset;
  final VoidCallback onSearch;
  final String resetLabel;
  final String searchLabel;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
        child: Row(
          children: [
            Expanded(
              child: SecondaryButton(
                label: resetLabel,
                leadingIcon: Icons.refresh,
                fullWidth: true,
                onPressed: onReset,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: PrimaryButton(
                label: searchLabel,
                leadingIcon: Icons.search,
                fullWidth: true,
                onPressed: onSearch,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
