import 'package:flutter/material.dart';

/// Paints the bar with rounded top corners and a notch centered on [fabX].
/// Same path as `green_mark_customer`'s `NotchedNavPainter`. The notch edges
/// are limited near the screen sides, so the overshoot of the bounce never
/// draws outside the bar.
class FmBottomNavPainter extends CustomPainter {
  const FmBottomNavPainter({required this.fabX, required this.color});

  final double fabX;
  final Color color;

  static const _cornerRadius = 25.0;
  static const _notchWidth = 60.0;
  static const _notchHeight = 30.0;
  static const _notchStartOffset = 25.0;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final notchLeftStart = fabX - _notchWidth * 0.5 - _notchStartOffset;
    final notchRightEnd = fabX + _notchWidth * 0.5 + _notchStartOffset;
    const leftLimit = _cornerRadius;
    final rightLimit = size.width - _cornerRadius;

    final path = Path()
      ..moveTo(0, _cornerRadius)
      ..quadraticBezierTo(0, 0, _cornerRadius, 0);

    if (notchLeftStart > leftLimit) path.lineTo(notchLeftStart, 0);

    // Notch — left half
    path.cubicTo(
      fabX - _notchWidth * 0.5,
      0,
      fabX - _notchWidth * 0.35,
      _notchHeight,
      fabX,
      _notchHeight,
    );

    // Notch — right half
    if (notchRightEnd < rightLimit) {
      path
        ..cubicTo(
          fabX + _notchWidth * 0.35,
          _notchHeight,
          fabX + _notchWidth * 0.5,
          0,
          notchRightEnd,
          0,
        )
        ..lineTo(rightLimit, 0);
    } else {
      path.cubicTo(
        fabX + _notchWidth * 0.35,
        _notchHeight,
        fabX + _notchWidth * 0.5,
        0,
        rightLimit,
        0,
      );
    }

    path
      ..quadraticBezierTo(size.width, 0, size.width, _cornerRadius)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(FmBottomNavPainter old) =>
      old.fabX != fabX || old.color != color;
}
