import 'dart:ui';

import 'package:flutter/material.dart';

class RoadmapPathPainter extends CustomPainter {
  const RoadmapPathPainter({
    required this.itemCount,
    required this.itemHeight,
    required this.nodeSize,
  });
  final int itemCount;
  final double itemHeight;
  final double nodeSize;

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();

    final centerX = size.width / 2;

    for (int i = 0; i < itemCount - 1; i++) {
      final startY = i * itemHeight + nodeSize / 2;
      final endY = (i + 1) * itemHeight + nodeSize / 2;

      final startX = i.isEven
          ? 40 + nodeSize / 2
          : size.width - 40 - nodeSize / 2;

      final endX = (i + 1).isEven
          ? 40 + nodeSize / 2
          : size.width - 40 - nodeSize / 2;

      if (i == 0) {
        path.moveTo(startX, startY);
      }

      path.cubicTo(
        centerX,
        startY + itemHeight * .35,
        centerX,
        endY - itemHeight * .35,
        endX,
        endY,
      );
    }

    final paint = Paint()
      ..color = const Color(0xFFE5E1DA)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round;

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant RoadmapPathPainter oldDelegate) {
    return oldDelegate.itemCount != itemCount;
  }
}
