import 'package:flutter/material.dart';

/// Decoration that draws a dashed rounded-rectangle border — use as a
/// `Container`'s `decoration` for "drop a file here" / upload-area affordances.
class DashedBorderDecoration extends Decoration {
  final double borderRadius;
  final Color color;
  final double dashWidth;
  final double dashSpace;
  final double strokeWidth;

  const DashedBorderDecoration({
    required this.borderRadius,
    required this.color,
    required this.dashWidth,
    required this.dashSpace,
    required this.strokeWidth,
  });

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _DashedBorderPainter(
      borderRadius: borderRadius,
      color: color,
      dashWidth: dashWidth,
      dashSpace: dashSpace,
      strokeWidth: strokeWidth,
    );
  }
}

class _DashedBorderPainter extends BoxPainter {
  final double borderRadius;
  final Color color;
  final double dashWidth;
  final double dashSpace;
  final double strokeWidth;

  _DashedBorderPainter({
    required this.borderRadius,
    required this.color,
    required this.dashWidth,
    required this.dashSpace,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final rect = offset & configuration.size!;
    final rrect = RRect.fromRectAndRadius(rect, Radius.circular(borderRadius));
    final path = Path()..addRRect(rrect);

    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final dashPath = _createDashedPath(path);
    canvas.drawPath(dashPath, paint);
  }

  Path _createDashedPath(Path source) {
    final dashedPath = Path();
    for (final metric in source.computeMetrics()) {
      double distance = 0;
      while (distance < metric.length) {
        final end = (distance + dashWidth).clamp(0, metric.length).toDouble();
        dashedPath.addPath(metric.extractPath(distance, end), Offset.zero);
        distance += dashWidth + dashSpace;
      }
    }
    return dashedPath;
  }
}
