import 'package:flutter/material.dart';

import '../theme/app_colors_extension.dart';
import 'app_input.dart';
import 'drag_handle.dart';
import 'picker_option_tile.dart';

/// Option count past which [PickerSheet] shows a search field. Short lookups
/// (gender, status) stay clean; long ones (districts, wards) get live
/// filtering.
const _kSearchThreshold = 8;

class PickerOption<T> {
  const PickerOption({
    required this.value,
    required this.labelEn,
    required this.labelNp,
  });

  final T value;
  final String labelEn;
  final String labelNp;
}

/// Generic single-select bottom-sheet picker. Renders bilingual options and
/// returns the picked [PickerOption] (or `null` if the user dismisses). When
/// the list is long (> [_kSearchThreshold]) a search field appears that
/// filters live on either the English or the Nepali label.
///
/// Unlike the app-owned version this was extracted from, [searchHint] /
/// [noResultsLabel] are required — a shared package can't read any one app's
/// generated `AppLocalizations` class, so the caller resolves its own
/// localized copy and passes it in.
class PickerSheet<T> extends StatefulWidget {
  const PickerSheet({
    super.key,
    required this.title,
    required this.options,
    required this.searchHint,
    required this.noResultsLabel,
    this.selected,
    this.onClear,
    this.clearTooltip,
  });

  final String title;
  final List<PickerOption<T>> options;
  final T? selected;
  final String searchHint;
  final String noResultsLabel;
  final String? clearTooltip;

  /// When set, a clear button appears next to the dismiss button whenever
  /// [selected] is non-null. Tapping it invokes this callback and closes the
  /// sheet — the caller unselects its field from within the callback, since
  /// the sheet always returns `PickerOption<T>`, which can't carry "no
  /// selection" for a non-nullable [T].
  final VoidCallback? onClear;

  static Future<PickerOption<T>?> show<T>(
    BuildContext context, {
    required String title,
    required List<PickerOption<T>> options,
    required String searchHint,
    required String noResultsLabel,
    T? selected,
    VoidCallback? onClear,
    String? clearTooltip,
  }) {
    return showModalBottomSheet<PickerOption<T>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => PickerSheet<T>(
        title: title,
        options: options,
        searchHint: searchHint,
        noResultsLabel: noResultsLabel,
        selected: selected,
        onClear: onClear,
        clearTooltip: clearTooltip,
      ),
    );
  }

  @override
  State<PickerSheet<T>> createState() => _PickerSheetState<T>();
}

class _PickerSheetState<T> extends State<PickerSheet<T>> {
  final _searchController = TextEditingController();
  String _query = '';

  bool get _showSearch => widget.options.length > _kSearchThreshold;

  /// Options filtered by [_query] — matches the English or the Nepali label.
  List<PickerOption<T>> get _filtered {
    if (_query.isEmpty) return widget.options;
    return widget.options
        .where(
          (o) =>
              o.labelEn.toLowerCase().contains(_query) ||
              o.labelNp.toLowerCase().contains(_query),
        )
        .toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final filtered = _filtered;

    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      minChildSize: 0.3,
      maxChildSize: 0.9,
      expand: false,
      builder: (_, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              const DragHandle(),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 2, 8, 6),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: colors.onSurface,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, size: 20),
                      visualDensity: VisualDensity.compact,
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
              if (_showSearch)
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                  child: AppInput(
                    hint: widget.searchHint,
                    controller: _searchController,
                    onChanged: (v) =>
                        setState(() => _query = v.trim().toLowerCase()),
                    suffix: _query.isEmpty
                        ? Icon(Icons.search, color: colors.onSurfaceVariant)
                        : GestureDetector(
                            onTap: () {
                              _searchController.clear();
                              setState(() => _query = '');
                            },
                            child: Icon(
                              Icons.close,
                              color: colors.onSurfaceVariant,
                            ),
                          ),
                  ),
                ),
              Expanded(
                child: filtered.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.search_off,
                              size: 40,
                              color: colors.onSurfaceVariant.withValues(
                                alpha: 0.6,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              widget.noResultsLabel,
                              style: TextStyle(
                                fontSize: 14,
                                color: colors.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        controller: scrollController,
                        padding: EdgeInsets.fromLTRB(
                          8,
                          2,
                          8,
                          12 + MediaQuery.viewInsetsOf(context).bottom,
                        ),
                        itemCount: filtered.length,
                        itemBuilder: (_, i) {
                          final option = filtered[i];
                          final isSelected = option.value == widget.selected;
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 2),
                            child: PickerOptionTile(
                              labelEn: option.labelEn,
                              labelNp: option.labelNp,
                              isSelected: isSelected,
                              onTap: () => Navigator.pop(context, option),
                              clearTooltip: widget.clearTooltip,
                              onClear: isSelected && widget.onClear != null
                                  ? () {
                                      widget.onClear!();
                                      Navigator.pop(context);
                                    }
                                  : null,
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}
