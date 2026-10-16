import 'package:flutter/material.dart';

import '../theme/app_colors_extension.dart';

/// Horizontally scrollable segmented control. Shows chevron scroll buttons
/// when [options] overflows the visible width (> 4 items).
///
/// Unlike the app-owned version this was extracted from, [scrollLeftLabel] /
/// [scrollRightLabel] are optional accessibility labels instead of being
/// resolved from an app-specific `AppLocalizations` — pass your app's own
/// localized strings if you want screen readers to announce them; `null`
/// renders no label.
class SegmentedFilterBar extends StatefulWidget {
  final List<String> options;
  final String selectedOption;
  final ValueChanged<String> onSelect;
  final String? scrollLeftLabel;
  final String? scrollRightLabel;

  const SegmentedFilterBar({
    super.key,
    required this.options,
    required this.selectedOption,
    required this.onSelect,
    this.scrollLeftLabel,
    this.scrollRightLabel,
  });

  static const int _maxVisible = 4;

  @override
  State<SegmentedFilterBar> createState() => _SegmentedFilterBarState();
}

class _SegmentedFilterBarState extends State<SegmentedFilterBar> {
  final _controller = ScrollController();
  bool _canScrollLeft = false;
  bool _canScrollRight = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_updateScrollIndicators);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateScrollIndicators();
    });
  }

  @override
  void dispose() {
    _controller.removeListener(_updateScrollIndicators);
    _controller.dispose();
    super.dispose();
  }

  void _updateScrollIndicators() {
    if (!_controller.hasClients) return;
    final position = _controller.position;
    final canLeft = position.pixels > 0;
    final canRight = position.pixels < position.maxScrollExtent;
    if (canLeft != _canScrollLeft || canRight != _canScrollRight) {
      setState(() {
        _canScrollLeft = canLeft;
        _canScrollRight = canRight;
      });
    }
  }

  void _scrollBy(double delta) {
    if (!_controller.hasClients) return;
    final target = (_controller.offset + delta).clamp(
      0.0,
      _controller.position.maxScrollExtent,
    );
    _controller.animateTo(
      target,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final hasOverflow = widget.options.length > SegmentedFilterBar._maxVisible;
    if (!hasOverflow) {
      return _buildBar(scrollable: false);
    }
    return LayoutBuilder(
      builder: (context, constraints) {
        const spacing = 4.0;
        final itemWidth =
            (constraints.maxWidth - 64 - 3 * spacing) /
            SegmentedFilterBar._maxVisible;
        return Row(
          children: [
            _ChevronButton(
              isLeft: true,
              enabled: _canScrollLeft,
              label: widget.scrollLeftLabel,
              onTap: () => _scrollBy(-2 * itemWidth),
            ),
            const SizedBox(width: 4),
            Expanded(child: _buildBar(scrollable: true)),
            const SizedBox(width: 4),
            _ChevronButton(
              isLeft: false,
              enabled: _canScrollRight,
              label: widget.scrollRightLabel,
              onTap: () => _scrollBy(2 * itemWidth),
            ),
          ],
        );
      },
    );
  }

  Widget _buildBar({required bool scrollable}) {
    return Container(
      height: 36,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: context.appColors.outline,
        borderRadius: BorderRadius.circular(12),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          const spacing = 4.0;
          final visibleCount =
              widget.options.length < SegmentedFilterBar._maxVisible
              ? widget.options.length
              : SegmentedFilterBar._maxVisible;
          final totalSpacing = (visibleCount - 1) * spacing;
          final itemWidth =
              (constraints.maxWidth - totalSpacing) / visibleCount;

          return SingleChildScrollView(
            controller: scrollable ? _controller : null,
            scrollDirection: Axis.horizontal,
            physics: scrollable
                ? const BouncingScrollPhysics()
                : const NeverScrollableScrollPhysics(),
            child: Row(
              spacing: spacing,
              children: widget.options.map((option) {
                final bool isSelected = option == widget.selectedOption;

                return SizedBox(
                  width: itemWidth,
                  child: GestureDetector(
                    onTap: () => widget.onSelect(option),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? context.appColors.primary
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        option,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 13,

                          color: isSelected
                              ? Colors.white
                              : context.appColors.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}

class _ChevronButton extends StatelessWidget {
  final bool isLeft;
  final bool enabled;
  final String? label;
  final VoidCallback onTap;

  const _ChevronButton({
    required this.isLeft,
    required this.enabled,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: label,
      button: true,
      enabled: enabled,
      child: GestureDetector(
        onTap: enabled ? onTap : null,
        child: SizedBox(
          width: 28,
          height: 36,
          child: Center(
            child: Icon(
              isLeft ? Icons.chevron_left : Icons.chevron_right,
              size: 22,
              color: enabled
                  ? context.appColors.primary
                  : context.appColors.onSurfaceVariant.withValues(alpha: 0.4),
            ),
          ),
        ),
      ),
    );
  }
}
