import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme/app_colors_extension.dart';

/// Filled text input with a native floating label and a 1.5 dp bottom
/// underline.
///
/// The label sits inside the field as a placeholder when empty and floats
/// up — shrinking — on focus or once the field is filled. The underline is
/// transparent at rest, `primary` on focus, and `error` when [errorText] is
/// set; the error / helper message renders below the field.
class AppInput extends StatefulWidget {
  const AppInput({
    super.key,
    this.label,
    this.hint,
    this.controller,
    this.prefix,
    this.suffix,
    this.keyboardType,
    this.inputFormatters,
    this.validator,
    this.onChanged,
    this.readOnly = false,
    this.obscureText = false,
    this.autofocus = false,
    this.selectAllOnFocus = true,
    this.isRequired = false,
    this.textAlign = TextAlign.start,
    this.errorText,
    this.helperText,
    this.isPaddingEnabled = true,
  });

  final String? label;
  final String? hint;
  final TextEditingController? controller;
  final String? prefix;
  final Widget? suffix;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final bool readOnly;
  final bool obscureText;
  final bool autofocus;
  final bool selectAllOnFocus;

  /// When true, renders a red `*` after the label to flag the field as
  /// required. Purely visual — validation lives at the form level.
  final bool isRequired;
  final TextAlign textAlign;
  final String? errorText;
  final String? helperText;
  final bool isPaddingEnabled;

  @override
  State<AppInput> createState() => _AppInputState();
}

class _AppInputState extends State<AppInput> {
  final _focus = FocusNode();
  bool _focused = false;

  @override
  void initState() {
    super.initState();
    _focus.addListener(_onFocusChanged);
  }

  void _onFocusChanged() {
    if (!mounted) return;
    setState(() => _focused = _focus.hasFocus);
    if (!_focus.hasFocus) return;
    if (!widget.selectAllOnFocus) return;
    final controller = widget.controller;
    if (controller == null) return;
    // Defer to post-frame: TextField's gesture handler positions the caret
    // *after* the focus listener fires; setting selection synchronously gets
    // overwritten. Running on the next frame lands last.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || !_focus.hasFocus) return;
      final text = controller.text;
      if (text.isEmpty) return;
      controller.selection = TextSelection(
        baseOffset: 0,
        extentOffset: text.length,
      );
    });
  }

  @override
  void dispose() {
    _focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final hasError = widget.errorText != null;
    final tabularFigures =
        widget.prefix != null || widget.keyboardType == TextInputType.number;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            color: colors.surfaceLow,
            borderRadius: BorderRadius.circular(12),
            border: Border(
              bottom: BorderSide(
                color: hasError
                    ? colors.error
                    : (_focused ? colors.primary : Colors.transparent),
                width: 1.5,
              ),
            ),
          ),
          child: TextField(
            controller: widget.controller,
            focusNode: _focus,
            obscureText: widget.obscureText,
            keyboardType: widget.keyboardType,
            autocorrect: false,
            inputFormatters: widget.inputFormatters,
            onChanged: widget.onChanged,
            readOnly: widget.readOnly,
            autofocus: widget.autofocus,
            selectAllOnFocus: widget.selectAllOnFocus,
            textAlign: widget.textAlign,
            style: TextStyle(
              fontSize: 14,
              color: colors.onSurface,
              fontFeatures: tabularFigures
                  ? const [FontFeature.tabularFigures()]
                  : null,
            ),
            decoration: InputDecoration(
              isDense: true,
              filled: false,
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              contentPadding: widget.isPaddingEnabled
                  ? const EdgeInsets.fromLTRB(12, 8, 12, 8)
                  : EdgeInsets.zero,
              label: widget.label == null
                  ? null
                  : Text.rich(
                      TextSpan(
                        style: TextStyle(
                          fontSize: 13,
                          color: hasError
                              ? colors.error
                              : colors.onSurfaceVariant,
                        ),
                        children: [
                          TextSpan(text: widget.label),
                          if (widget.isRequired)
                            TextSpan(
                              text: ' *',
                              style: TextStyle(color: colors.error),
                            ),
                        ],
                      ),
                    ),
              labelStyle: TextStyle(
                fontSize: 15,
                color: hasError ? colors.error : colors.onSurfaceVariant,
              ),
              floatingLabelStyle: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.4,
                color: hasError
                    ? colors.error
                    : (_focused ? colors.primary : colors.onSurfaceVariant),
              ),
              hintText: widget.hint,
              hintStyle: TextStyle(
                fontSize: 15,
                color: colors.onSurfaceVariant.withValues(alpha: 0.5),
              ),
              prefixText: widget.prefix,
              prefixStyle: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: colors.onSurfaceVariant,
                fontFeatures: const [FontFeature.tabularFigures()],
              ),
              suffixIcon: widget.suffix,
              suffixIconConstraints: const BoxConstraints(maxHeight: 32),
            ),
          ),
        ),
        if (widget.helperText != null || widget.errorText != null)
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 4),
            child: Text(
              widget.errorText ?? widget.helperText!,
              style: TextStyle(
                fontSize: 12,
                color: hasError ? colors.error : colors.onSurfaceVariant,
              ),
            ),
          ),
      ],
    );
  }
}
