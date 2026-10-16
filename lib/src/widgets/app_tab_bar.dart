import 'package:flutter/material.dart';

import '../theme/app_colors_extension.dart';

/// A theme-aware [TabBar] that accepts label strings or custom widgets.
class AppTabBar extends StatelessWidget implements PreferredSizeWidget {
  const AppTabBar({
    super.key,
    this.tabs,
    this.tabWidgets,
    this.controller,
    this.indicatorColor,
    this.labelColor,
    this.unselectedColor,
    this.indicatorWeight = 2,
    this.padding = const EdgeInsets.symmetric(horizontal: 16),
    this.alignment = TabAlignment.start,
    this.isScrollable = false,
    this.dividerColor,
  }) : assert(
          tabs != null || tabWidgets != null,
          'Either tabs or tabWidgets must be provided',
        );

  final List<String>? tabs;
  final List<Widget>? tabWidgets;
  final TabController? controller;
  final Color? indicatorColor;
  final Color? labelColor;
  final Color? unselectedColor;
  final double indicatorWeight;
  final EdgeInsetsGeometry padding;
  final TabAlignment alignment;
  final bool isScrollable;
  final Color? dividerColor;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final active = indicatorColor ?? colors.primary;
    final activeLabel = labelColor ?? colors.primary;
    final unselected = unselectedColor ?? colors.onSurfaceVariant;

    final effectiveTabs = tabs != null
        ? tabs!.map((label) => Tab(text: label)).toList()
        : tabWidgets!;

    final tabBar = TabBar(
      controller: controller,
      tabs: effectiveTabs,
      isScrollable: isScrollable,
      tabAlignment: alignment,
      indicatorColor: active,
      indicatorWeight: indicatorWeight,
      labelColor: activeLabel,
      unselectedLabelColor: unselected,
      dividerColor: dividerColor ?? colors.outlineVariant,
    );

    return Padding(
      padding: padding,
      child: tabBar,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

/// Backward compatibility alias for [AppTabBar].
typedef CustomTabBar = AppTabBar;
