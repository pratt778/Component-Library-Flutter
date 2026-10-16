import 'package:flutter/material.dart';

import '../theme/app_colors_extension.dart';
import 'fm_bottom_nav_inactive_tab.dart';
import 'fm_bottom_nav_painter.dart';

/// Bottom navigation bar with a notch that bounces to the active tab.
///
/// Motion ported from `green_mark_customer`: a 350 ms controller with
/// `Curves.easeOutBack`, so the notch and the floating button overshoot a
/// little and settle. The active icon swaps instantly; the other tabs sit in
/// the bar and the active slot is left empty for the floating button.
///
/// Unlike the app-owned version this was extracted from, [tabs] is a
/// required parameter instead of a hardcoded, `AppLocalizations`-derived
/// list — a shared package can't read any one app's generated localization
/// class, so each app builds its own tab list (icon + already-localized
/// label) and passes it in. Tab order is positional and must match the
/// router's branch order — [activeIndex] is a branch index. [onTap] receives
/// the tapped branch index.
class FmBottomNav extends StatefulWidget {
  const FmBottomNav({
    super.key,
    required this.activeIndex,
    required this.tabs,
    this.onTap,
  });

  final int activeIndex;
  final List<({IconData icon, String label})> tabs;
  final ValueChanged<int>? onTap;

  static const _barHeight = 70.0;
  static const _fabSize = 48.0;
  static const _headroom = 28.0;
  static const _fabLift = _headroom - 25.0; // button sits 25 above the bar

  /// How far the first and last tabs sit from the screen edges, as a fraction
  /// of the width. 0.20 → three tabs at 20% / 50% / 80%, two tabs at 20% /
  /// 80%. Lower = closer to the edges, higher = closer together.
  static const _edgeInset = 0.20;

  @override
  State<FmBottomNav> createState() => _FmBottomNavState();
}

class _FmBottomNavState extends State<FmBottomNav>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late Animation<double> _position; // active tab index, animated

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );
    _position = _tween(
      widget.activeIndex.toDouble(),
      widget.activeIndex.toDouble(),
    );
  }

  Animation<double> _tween(double begin, double end) =>
      Tween<double>(begin: begin, end: end).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Curves.easeOutBack, // slight overshoot = the bounce
        ),
      );

  @override
  void didUpdateWidget(FmBottomNav oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.activeIndex != widget.activeIndex) {
      // Animate from wherever the notch currently is, so a quick second tap
      // redirects it smoothly instead of snapping back.
      _position = _tween(_position.value, widget.activeIndex.toDouble());
      _controller.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final primary = context.appColors.primary;
    // Bar slightly darker than the floating button, as in green_mark_customer.
    final barColor = Color.lerp(primary, Colors.black, 0.18)!;
    final bottomInset = MediaQuery.viewPaddingOf(context).bottom;
    final tabs = widget.tabs;

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        double centerX(num index) {
          if (tabs.length == 1) return width / 2;
          final t = index / (tabs.length - 1); // 0 → first tab, 1 → last tab
          return width *
              (FmBottomNav._edgeInset + (1 - 2 * FmBottomNav._edgeInset) * t);
        }

        return AnimatedBuilder(
          animation: _position,
          builder: (context, _) {
            final fabX = centerX(_position.value);

            return SizedBox(
              height:
                  FmBottomNav._headroom + FmBottomNav._barHeight + bottomInset,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  // 1. Bar with the animated notch.
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    height: FmBottomNav._barHeight + bottomInset,
                    child: CustomPaint(
                      painter: FmBottomNavPainter(fabX: fabX, color: barColor),
                    ),
                  ),
                  // 2. Non-selected tabs; the active slot is left empty.
                  for (var i = 0; i < tabs.length; i++)
                    if (i != widget.activeIndex)
                      FmBottomNavInactiveTab(
                        centerX: centerX(i),
                        bottom: bottomInset + 14,
                        icon: tabs[i].icon,
                        label: tabs[i].label,
                        opacity: 1,
                        onTap: () => widget.onTap?.call(i),
                      ),
                  // 3. Floating button that rides the notch.
                  Positioned(
                    top: FmBottomNav._fabLift,
                    left: fabX - FmBottomNav._fabSize / 2,
                    child: GestureDetector(
                      onTap: () => widget.onTap?.call(widget.activeIndex),
                      child: Container(
                        width: FmBottomNav._fabSize,
                        height: FmBottomNav._fabSize,
                        decoration: BoxDecoration(
                          color: primary,
                          shape: BoxShape.circle,
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 8,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Icon(
                          tabs[widget.activeIndex].icon,
                          size: 22,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

/// Generic naming alias for [FmBottomNav].
typedef CurvedBottomNav = FmBottomNav;
