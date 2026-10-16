import 'package:flutter/material.dart';

import '../theme/app_colors_extension.dart';

/// Tappable dropdown field styled to match [AppInput] — same filled shell,
/// radius and bottom underline, and the same native floating label: the
/// label rides inside the field as a placeholder when empty and floats up
/// once a [value] is picked. Tapping fires [onTap], which typically opens a
/// picker sheet.
class AppDropdown extends StatelessWidget {
  const AppDropdown({
    super.key,
    this.label,
    this.value,
    this.hint,
    this.onTap,
    this.focused = false,
    this.isRequired = false,
    this.errorText,
    this.readOnly = false,
    this.onClear,
  });

  final String? label;
  final String? value;

  /// Retained for API compatibility. The floating label is the placeholder
  /// when empty, so a separate hint is no longer rendered.
  final String? hint;
  final VoidCallback? onTap;
  final bool focused;

  /// When true, renders a red `*` after the label to flag the field as
  /// required. Purely visual.
  final bool isRequired;

  /// Validation message shown below the field; also tints the bottom
  /// border red. `null` = no error.
  final String? errorText;

  /// When true, the field is non-interactive: taps are ignored and the
  /// chevron suffix is hidden. Use for display-only contexts (e.g. fields
  /// derived from another selection that the user shouldn't change directly).
  final bool readOnly;

  /// Shows a clear (×) button before the chevron whenever [value] is set.
  /// Only meaningful for fields whose [onTap] bypasses a picker sheet (e.g.
  /// the native date pickers, which have no clear action of their own) —
  /// sheet-backed fields typically clear from inside the sheet instead.
  final VoidCallback? onClear;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final hasValue = value != null && value!.isNotEmpty;
    final hasError = errorText != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: readOnly || onTap == null
              ? null
              : () {
                  FocusScope.of(context).unfocus();
                  onTap!();
                },
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: colors.surfaceLow,
              borderRadius: BorderRadius.circular(12),
              border: Border(
                bottom: BorderSide(
                  color: hasError
                      ? colors.error
                      : (focused ? colors.primary : Colors.transparent),
                  width: 1.5,
                ),
              ),
            ),
            child: InputDecorator(
              isEmpty: !hasValue,
              isFocused: focused,
              decoration: InputDecoration(
                isDense: true,

                filled: false,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: const EdgeInsets.fromLTRB(12, 8, 8, 8),
                label: label == null
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
                            TextSpan(text: label),
                            if (isRequired)
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
                      : (focused ? colors.primary : colors.onSurfaceVariant),
                ),

                suffixIcon: readOnly
                    ? null
                    : Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,

                          children: [
                            if (hasValue && onClear != null) ...[
                              GestureDetector(
                                onTap: onClear,
                                child: Icon(
                                  Icons.cancel,
                                  size: 18,
                                  color: colors.onSurfaceVariant,
                                ),
                              ),
                              const SizedBox(width: 6),
                            ],
                            Icon(
                              Icons.expand_more,
                              size: 20,
                              color: colors.onSurfaceVariant,
                            ),
                          ],
                        ),
                      ),
                suffixIconConstraints: const BoxConstraints(maxHeight: 32),
              ),
              child: Text(
                hasValue ? value! : '',
                style: TextStyle(fontSize: 15, color: colors.onSurface),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
        if (hasError)
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 4),
            child: Text(
              errorText!,
              style: TextStyle(fontSize: 12, color: colors.error),
            ),
          ),
      ],
    );
  }
}
