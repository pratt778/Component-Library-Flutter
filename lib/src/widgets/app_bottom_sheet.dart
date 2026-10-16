import 'package:flutter/material.dart';

import '../theme/app_colors_extension.dart';
import 'drag_handle.dart';

/// A theme-aware bottom sheet container with drag handle, title, body, and actions.
class AppBottomSheet extends StatelessWidget {
  const AppBottomSheet({
    super.key,
    this.body,
    this.title,
    this.actions,
    this.backgroundColor,
    this.showDragHandle = true,
    this.showDivider = true,
    this.padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
    this.maxHeight,
    this.borderRadius = 16,
  });

  final Widget? body;
  final Widget? title;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final bool showDragHandle;
  final bool showDivider;
  final EdgeInsetsGeometry padding;
  final double? maxHeight;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final bg = backgroundColor ?? colors.surface;
    final dividerColor = colors.outlineVariant;

    final sheetContent = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (showDragHandle) const Center(child: DragHandle()),
        if (title != null) ...[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: title!,
          ),
          if (showDivider) Divider(height: 1, thickness: 1, color: dividerColor),
        ],
        if (body != null)
          Flexible(
            child: SingleChildScrollView(
              padding: padding,
              child: body!,
            ),
          ),
        if (actions != null && actions!.isNotEmpty) ...[
          if (showDivider) Divider(height: 1, thickness: 1, color: dividerColor),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: actions!,
            ),
          ),
        ],
      ],
    );

    return Container(
      constraints: maxHeight != null ? BoxConstraints(maxHeight: maxHeight!) : null,
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(borderRadius),
          topRight: Radius.circular(borderRadius),
        ),
      ),
      child: SafeArea(child: sheetContent),
    );
  }

  /// Shows the modal bottom sheet and returns the popped result.
  static Future<T?> show<T>(
    BuildContext context, {
    Widget? body,
    Widget? title,
    List<Widget>? actions,
    Color? backgroundColor,
    bool isDismissible = true,
    bool enableDrag = true,
    bool isScrollControlled = true,
    double? maxHeight,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      isScrollControlled: isScrollControlled,
      backgroundColor: Colors.transparent,
      builder: (context) => AppBottomSheet(
        body: body,
        title: title,
        actions: actions,
        backgroundColor: backgroundColor,
        maxHeight: maxHeight,
      ),
    );
  }
}

/// Backward compatibility alias for [AppBottomSheet].
typedef CustomBottomSheet = AppBottomSheet;
