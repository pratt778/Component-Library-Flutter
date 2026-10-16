import 'package:flutter/material.dart';

import '../theme/app_colors_extension.dart';

/// A single item for an [AppNavigationBar].
class AppNavigationItem {
  const AppNavigationItem({
    required this.icon,
    this.activeIcon,
    required this.label,
    this.badge,
  });

  final IconData icon;
  final IconData? activeIcon;
  final String label;
  final Widget? badge;
}

/// Backward compatibility alias for [AppNavigationItem].
typedef NavigationItem = AppNavigationItem;

/// A theme-aware bottom navigation bar.
class AppNavigationBar extends StatelessWidget {
  const AppNavigationBar({
    super.key,
    required this.items,
    this.selectedIndex = 0,
    this.onDestinationSelected,
    this.backgroundColor,
    this.selectedColor,
    this.unselectedColor,
    this.elevation = 0,
    this.height = 64,
    this.padding = const EdgeInsets.symmetric(horizontal: 8),
    this.borderRadius = 0,
  });

  final List<AppNavigationItem> items;
  final int selectedIndex;
  final ValueChanged<int>? onDestinationSelected;
  final Color? backgroundColor;
  final Color? selectedColor;
  final Color? unselectedColor;
  final double elevation;
  final double height;
  final EdgeInsetsGeometry padding;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final bg = backgroundColor ?? colors.surface;
    final active = selectedColor ?? colors.primary;
    final inactive = unselectedColor ?? colors.onSurfaceVariant;

    return SafeArea(
      top: false,
      child: Material(
        color: bg,
        elevation: elevation,
        borderRadius: BorderRadius.vertical(top: Radius.circular(borderRadius)),
        child: Container(
          height: height,
          padding: padding,
          decoration: BoxDecoration(
            border: Border(top: BorderSide(color: colors.outlineVariant)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(items.length, (index) {
              final item = items[index];
              final isSelected = index == selectedIndex;
              final iconData = (isSelected && item.activeIcon != null)
                  ? item.activeIcon!
                  : item.icon;

              Widget iconWidget = Icon(
                iconData,
                color: isSelected ? active : inactive,
                size: 24,
              );

              if (item.badge != null) {
                iconWidget = Stack(
                  clipBehavior: Clip.none,
                  children: [
                    iconWidget,
                    Positioned(top: -4, right: -6, child: item.badge!),
                  ],
                );
              }

              return Expanded(
                child: InkWell(
                  onTap: () => onDestinationSelected?.call(index),
                  borderRadius: BorderRadius.circular(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      iconWidget,
                      const SizedBox(height: 4),
                      Text(
                        item.label,
                        style: TextStyle(
                          color: isSelected ? active : inactive,
                          fontSize: 12,
                          fontWeight: isSelected
                              ? FontWeight.w600
                              : FontWeight.w400,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

/// Backward compatibility alias for [AppNavigationBar].
typedef CustomNavigationBar = AppNavigationBar;
