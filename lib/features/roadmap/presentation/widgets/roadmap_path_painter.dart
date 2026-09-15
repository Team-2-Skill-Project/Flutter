import 'dart:math';

import 'package:flutter/material.dart';

/// CustomPainter rendering an old treasure-map style dashed curve connecting task nodes.
class RoadmapPathPainter extends CustomPainter {
  RoadmapPathPainter({
    required this.nodeCenters,
    this.pathColor = const Color(0xFF8B5A2B),
    this.strokeWidth = 3.5,
    this.dashLength = 9.0,
    this.dashGap = 7.0,
  });

  /// Exact center coordinates for each task node
  final List<Offset> nodeCenters;

  /// Earthy treasure map path color
  final Color pathColor;

  /// Line thickness
  final double strokeWidth;

  /// Length of each dash
  final double dashLength;

  /// Gap between dashes
  final double dashGap;

  @override
  void paint(Canvas canvas, Size size) {
    if (nodeCenters.length < 2) return;

    final paint = Paint()
      ..color = pathColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final fullPath = Path();
    fullPath.moveTo(nodeCenters.first.dx, nodeCenters.first.dy);

    for (int i = 0; i < nodeCenters.length - 1; i++) {
      final p1 = nodeCenters[i];
      final p2 = nodeCenters[i + 1];

      final dy = p2.dy - p1.dy;
      // Organic cubic bezier curve connecting node centers
      final c1 = Offset(p1.dx, p1.dy + dy * 0.5);
      final c2 = Offset(p2.dx, p2.dy - dy * 0.5);

      fullPath.cubicTo(c1.dx, c1.dy, c2.dx, c2.dy, p2.dx, p2.dy);
    }

    // Render dashed path using PathMetrics
    final pathMetrics = fullPath.computeMetrics();
    for (final metric in pathMetrics) {
      double distance = 0.0;
      while (distance < metric.length) {
        final double length = min(dashLength, metric.length - distance);
        final Path dashPath = metric.extractPath(distance, distance + length);
        canvas.drawPath(dashPath, paint);
        distance += dashLength + dashGap;
      }
    }
  }

  @override
  bool shouldRepaint(covariant RoadmapPathPainter oldDelegate) {
    if (oldDelegate.nodeCenters.length != nodeCenters.length) return true;
    for (int i = 0; i < nodeCenters.length; i++) {
      if (oldDelegate.nodeCenters[i] != nodeCenters[i]) return true;
    }
    return oldDelegate.pathColor != pathColor ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.dashLength != dashLength ||
        oldDelegate.dashGap != dashGap;
  }
}
