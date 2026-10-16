import 'package:flutter/material.dart';

/// Inactive icon-and-label rendered alongside the FAB scoop.
///
/// Designed for use inside [FmBottomNav]'s [Stack]: positions itself absolutely
/// at [centerX] / [bottom] and cross-fades via [opacity] as the active tab
/// changes. Pointer events are ignored when fully transparent so the tap
/// surface follows the visible label.
class FmBottomNavInactiveTab extends StatelessWidget {
  const FmBottomNavInactiveTab({
    super.key,
    required this.centerX,
    required this.bottom,
    required this.icon,
    required this.label,
    required this.opacity,
    required this.onTap,
  });

  final double centerX;
  final double bottom;
  final IconData icon;
  final String label;
  final double opacity;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: centerX - 30,
      bottom: bottom,
      width: 60,
      child: IgnorePointer(
        ignoring: opacity < 0.5,
        child: Opacity(
          opacity: opacity,
          child: GestureDetector(
            onTap: onTap,
            behavior: HitTestBehavior.opaque,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  size: 22,
                  color: Colors.white.withValues(alpha: 0.78),
                ),
                const SizedBox(height: 3),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: Colors.white.withValues(alpha: 0.78),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
