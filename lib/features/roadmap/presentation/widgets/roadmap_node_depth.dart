import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RoadmapNodeDepth extends StatelessWidget {
  const RoadmapNodeDepth({
    super.key,
    required this.size,
    required this.color,
    required this.isActive,
    required this.isPressed,
  });

  final double size;
  final Color color;
  final bool isActive;
  final bool isPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: isActive
            ? Border.all(color: const Color(0xFF1F365C), width: 1.5.w)
            : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isPressed ? 0.08 : 0.26),
            blurRadius: isPressed ? 2.r : 10.r,
            offset: Offset(0, isPressed ? 1.h : 6.h),
          ),
        ],
      ),
    );
  }
}
