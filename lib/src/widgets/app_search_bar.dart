import 'package:flutter/material.dart';

import '../theme/app_colors_extension.dart';
import '../utils/debouncer.dart';

/// A theme-aware search field with search icon, clear button, and optional debouncing.
class AppSearchBar extends StatefulWidget {
  const AppSearchBar({
    super.key,
    this.controller,
    this.hint = 'Search',
    this.onChanged,
    this.onSubmitted,
    this.onClear,
    this.debounceDuration = Duration.zero,
    this.fillColor,
    this.borderRadius = 24,
    this.height = 44,
    this.autofocus = false,
    this.showClearButton = true,
    this.leading,
    this.trailing,
  });

  final TextEditingController? controller;
  final String? hint;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onClear;
  final Duration debounceDuration;
  final Color? fillColor;
  final double borderRadius;
  final double height;
  final bool autofocus;
  final bool showClearButton;
  final Widget? leading;
  final Widget? trailing;

  @override
  State<AppSearchBar> createState() => _AppSearchBarState();
}

class _AppSearchBarState extends State<AppSearchBar> {
  late final TextEditingController _controller =
      widget.controller ?? TextEditingController();
  late final Debouncer _debouncer =
      Debouncer(duration: widget.debounceDuration);
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onTextChanged);
    _hasText = _controller.text.isNotEmpty;
  }

  @override
  void dispose() {
    _debouncer.dispose();
    _controller.removeListener(_onTextChanged);
    if (widget.controller == null) _controller.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    final hasText = _controller.text.isNotEmpty;
    if (hasText != _hasText) setState(() => _hasText = hasText);

    if (widget.onChanged != null) {
      if (widget.debounceDuration > Duration.zero) {
        _debouncer.run(() => widget.onChanged!(_controller.text));
      } else {
        widget.onChanged!(_controller.text);
      }
    }
  }

  void _clear() {
    _controller.clear();
    widget.onClear?.call();
    widget.onChanged?.call('');
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final bg = widget.fillColor ?? colors.surfaceLow;

    return SizedBox(
      height: widget.height,
      child: TextField(
        controller: _controller,
        autofocus: widget.autofocus,
        textInputAction: TextInputAction.search,
        onSubmitted: widget.onSubmitted,
        textAlignVertical: TextAlignVertical.center,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: colors.onSurface,
            ),
        decoration: InputDecoration(
          isDense: true,
          filled: true,
          fillColor: bg,
          hintText: widget.hint,
          hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: colors.onSurfaceVariant,
              ),
          prefixIcon: widget.leading ??
              Icon(Icons.search, size: 20, color: colors.onSurfaceVariant),
          suffixIcon: (_hasText && widget.showClearButton)
              ? IconButton(
                  icon: Icon(Icons.close, size: 18, color: colors.onSurfaceVariant),
                  onPressed: _clear,
                  tooltip: 'Clear',
                  splashRadius: 16,
                )
              : widget.trailing,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            borderSide: BorderSide(color: colors.outlineVariant),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            borderSide: BorderSide(color: colors.outlineVariant),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            borderSide: BorderSide(color: colors.primary, width: 1.5),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        ),
      ),
    );
  }
}

/// Backward compatibility alias for [AppSearchBar].
typedef CustomSearchBar = AppSearchBar;
