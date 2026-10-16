import 'package:flutter/material.dart';

import '../theme/app_colors_extension.dart';

/// A theme-aware navigation [Drawer] with flexible header, items, and footer.
class AppDrawer extends StatelessWidget {
  const AppDrawer({
    super.key,
    this.backgroundColor,
    this.elevation = 0,
    this.borderRadius,
    this.width = 280,
    this.padding = const EdgeInsets.symmetric(vertical: 12),
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    this.showDivider = true,
    this.dividerColor,
    this.dividerThickness = 1,
    this.header,
    this.items,
    this.footer,
    this.bottomPadding = const EdgeInsets.only(bottom: 24),
  });

  final Color? backgroundColor;
  final double elevation;
  final BorderRadius? borderRadius;
  final double width;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? contentPadding;
  final bool showDivider;
  final Color? dividerColor;
  final double dividerThickness;
  final Widget? header;
  final List<Widget>? items;
  final Widget? footer;
  final EdgeInsetsGeometry? bottomPadding;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final effectiveBg = backgroundColor ?? colors.surface;
    final effectiveDivider = dividerColor ?? colors.outlineVariant;

    return SafeArea(
      child: SizedBox(
        width: width,
        child: Material(
          color: effectiveBg,
          elevation: elevation,
          borderRadius: borderRadius ?? BorderRadius.zero,
          child: Padding(
            padding: padding ?? EdgeInsets.zero,
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    padding: contentPadding ?? EdgeInsets.zero,
                    children: [
                      if (header != null) ...[
                        header!,
                        if (showDivider)
                          Divider(
                            color: effectiveDivider,
                            thickness: dividerThickness,
                          ),
                      ],
                      ...?items,
                    ],
                  ),
                ),
                if (footer != null) ...[
                  if (showDivider)
                    Divider(color: effectiveDivider, thickness: dividerThickness),
                  Padding(
                    padding: bottomPadding ?? EdgeInsets.zero,
                    child: footer!,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Backward compatibility alias for [AppDrawer].
typedef CustomDrawer = AppDrawer;
