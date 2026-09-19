import 'package:MatchIn/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RoadmapNodeSurface extends StatelessWidget {
  const RoadmapNodeSurface({
    super.key,
    required this.size,
    required this.baseColor,
    required this.isActive,
    required this.isLocked,
    required this.iconData,
    required this.iconColor,
  });

  final double size;
  final Color baseColor;
  final bool isActive;
  final bool isLocked;
  final IconData iconData;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: baseColor,
        shape: BoxShape.circle,
        border: Border.all(
          color: isLocked
              ? colors.outline.withValues(alpha: 0.4)
              : isActive
              ? Colors.white.withValues(alpha: 0.6)
              : Colors.white.withValues(alpha: 0.45),
          width: isActive ? 2.5.w : 2.w,
        ),
        gradient: isLocked
            ? null
            : LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white.withValues(alpha: 0.35),
                  Colors.transparent,
                ],
                stops: const [0.0, 0.45],
              ),
      ),
      child: Center(
        child: Icon(
          iconData,
          color: iconColor,
          size: isActive
              ? 34.r
              : isLocked
              ? 26.r
              : 32.r,
        ),
      ),
    );
  }
}
