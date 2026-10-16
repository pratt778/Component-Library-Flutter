import 'package:flutter/material.dart';

import '../theme/app_colors_extension.dart';
import 'drag_handle.dart';
import 'filter_sheet_action_row.dart';
import 'filter_sheet_header.dart';

/// Reusable chrome for filter bottom sheets: drag handle, titled header,
/// divider, scrollable form content, and Reset / Search action row.
///
/// Each feature supplies its own form via [formBuilder]. [resetLabel] /
/// [searchLabel] are forwarded to [FilterSheetActionRow] — see its doc
/// comment for why they're required instead of resolved internally.
class FilterBottomSheetShell extends StatelessWidget {
  const FilterBottomSheetShell({
    super.key,
    required this.title,
    required this.formBuilder,
    required this.onReset,
    required this.onApply,
    required this.resetLabel,
    required this.searchLabel,
    this.closeTooltip,
    this.initialChildSize = 0.75,
    this.minChildSize = 0.4,
    this.maxChildSize = 0.95,
  });

  final String title;

  /// Builds the scrollable form content. Receives the [ScrollController]
  /// from [DraggableScrollableSheet] so the form can scroll inside it.
  final Widget Function(ScrollController scrollController) formBuilder;

  final VoidCallback onReset;
  final VoidCallback onApply;
  final String resetLabel;
  final String searchLabel;
  final String? closeTooltip;
  final double initialChildSize;
  final double minChildSize;
  final double maxChildSize;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;

    return DraggableScrollableSheet(
      initialChildSize: initialChildSize,
      minChildSize: minChildSize,
      maxChildSize: maxChildSize,
      expand: false,
      builder: (_, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          padding: EdgeInsets.only(bottom: bottomInset),
          child: Column(
            children: [
              const DragHandle(),
              FilterSheetHeader(
                title: title,
                onClose: () => Navigator.pop(context),
                closeTooltip: closeTooltip,
              ),
              const Divider(height: 1),
              Expanded(child: formBuilder(scrollController)),
              FilterSheetActionRow(
                onReset: onReset,
                onSearch: onApply,
                resetLabel: resetLabel,
                searchLabel: searchLabel,
              ),
            ],
          ),
        );
      },
    );
  }
}
