import 'package:flutter/material.dart';

import '../theme/app_colors_extension.dart';

/// A theme-aware splash screen with a branded loading spinner or custom child.
class AppSplashScreen extends StatelessWidget {
  const AppSplashScreen({
    super.key,
    this.background,
    this.foreground,
    this.backgroundColor,
    this.progressColor,
    this.radius = 0,
  });

  final Widget? background;
  final Widget? foreground;
  final Color? backgroundColor;
  final Color? progressColor;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final bg = backgroundColor ?? colors.primary;
    final progress = progressColor ?? colors.onPrimary;

    final defaultForeground = SizedBox(
      width: 44,
      height: 44,
      child: CircularProgressIndicator(
        color: progress,
        strokeWidth: 3,
      ),
    );

    return Scaffold(
      backgroundColor: bg,
      body: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: Stack(
          fit: StackFit.expand,
          children: [
            if (background != null) SizedBox.expand(child: background!),
            Center(child: foreground ?? defaultForeground),
          ],
        ),
      ),
    );
  }
}

/// Backward compatibility alias for [AppSplashScreen].
typedef CustomSplashScreen = AppSplashScreen;
