import 'package:MatchIn/core/utils/app_colors.dart';
import 'package:MatchIn/features/roadmap/data/models/roadmap_node.dart';
import 'package:MatchIn/features/roadmap/presentation/widgets/active_task_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RoadmapTaskNode extends StatefulWidget {
  const RoadmapTaskNode({
    super.key,
    required this.node,
    required this.onTap,
    this.circleKey,
  });

  final RoadmapNode node;
  final VoidCallback onTap;
  final Key? circleKey;

  @override
  State<RoadmapTaskNode> createState() => _RoadmapTaskNodeState();
}

class _RoadmapTaskNodeState extends State<RoadmapTaskNode> {
  bool _isPressed = false;

  void _onTapDown(TapDownDetails details) {
    setState(() {
      _isPressed = true;
    });
  }

  void _onTapUp(TapUpDetails details) {
    setState(() {
      _isPressed = false;
    });
  }

  void _onTapCancel() {
    setState(() {
      _isPressed = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final status = widget.node.status;
    final isCompleted = status == RoadmapTaskStatus.completed;
    final isActive = status == RoadmapTaskStatus.active;
    final isLocked = status == RoadmapTaskStatus.locked;

    final baseColor = _getNodeColor(status);
    final depthColor = _getDepthColor(status);
    final iconColor = isLocked ? AppColors.textHint : Colors.white;

    final double circleSize = 68.r;
    final double depthHeight = 6.h;
    final double pressOffset = _isPressed ? 5.h : 0.0;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // START indicator bubble for ACTIVE task
        if (isActive) ...[
          const ActiveTaskIndicator(),
          SizedBox(height: 8.h),
        ],

        // 3D Pressable Circular Node Button
        GestureDetector(
          onTapDown: _onTapDown,
          onTapUp: _onTapUp,
          onTapCancel: _onTapCancel,
          onTap: widget.onTap,
          behavior: HitTestBehavior.opaque,
          child: SizedBox(
            key: widget.circleKey,
            width: isActive ? 84.r : circleSize,
            height: (isActive ? 84.r : circleSize) + depthHeight,
            child: Stack(
              alignment: Alignment.topCenter,
              clipBehavior: Clip.none,
              children: [
                // Active ring background for ACTIVE task
                if (isActive)
                  Positioned(
                    top: pressOffset,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 100),
                      width: 84.r,
                      height: 84.r,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.primary.withValues(alpha: 0.35),
                          width: 5.w,
                        ),
                      ),
                    ),
                  ),

                // 3D Bottom Depth Layer (visible edge under top face)
                Positioned(
                  top: (isActive ? 8.r : 0) + depthHeight,
                  child: Container(
                    width: circleSize,
                    height: circleSize,
                    decoration: BoxDecoration(
                      color: depthColor,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: _isPressed ? 0.08 : 0.22),
                          blurRadius: _isPressed ? 3.r : 8.r,
                          offset: Offset(0, _isPressed ? 1.h : 4.h),
                        ),
                      ],
                    ),
                  ),
                ),

                // 3D Top Face Layer (translates downward on tap)
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 100),
                  curve: Curves.easeOut,
                  top: (isActive ? 8.r : 0) + pressOffset,
                  child: Container(
                    width: circleSize,
                    height: circleSize,
                    decoration: BoxDecoration(
                      color: baseColor,
                      shape: BoxShape.circle,
                      border: isLocked
                          ? Border.all(color: AppColors.border.withValues(alpha: 0.5), width: 2.w)
                          : null,
                      gradient: isLocked
                          ? null
                          : LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.white.withValues(alpha: 0.25),
                                Colors.transparent,
                              ],
                              stops: const [0.0, 0.45],
                            ),
                    ),
                    child: Center(
                      child: Icon(
                        _getNodeIcon(widget.node),
                        color: iconColor,
                        size: isCompleted ? 32.r : 28.r,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        SizedBox(height: 12.h),

        // Node Title
        SizedBox(
          width: 140.w,
          child: Text(
            widget.node.title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 14.sp,
              color: isLocked ? AppColors.textHint : AppColors.secondary,
            ),
          ),
        ),

        // Node Subtitle (if available)
        if (widget.node.subtitle != null) ...[
          SizedBox(height: 2.h),
          SizedBox(
            width: 140.w,
            child: Text(
              widget.node.subtitle!,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11.sp,
                fontWeight: FontWeight.w500,
                color: isLocked
                    ? AppColors.textHint.withValues(alpha: 0.7)
                    : AppColors.textSecondary,
              ),
            ),
          ),
        ],
      ],
    );
  }

  Color _getNodeColor(RoadmapTaskStatus status) {
    switch (status) {
      case RoadmapTaskStatus.completed:
        return AppColors.success;
      case RoadmapTaskStatus.active:
        return AppColors.primary;
      case RoadmapTaskStatus.locked:
        return AppColors.surfaceVariant;
    }
  }

  Color _getDepthColor(RoadmapTaskStatus status) {
    switch (status) {
      case RoadmapTaskStatus.completed:
        return const Color(0xFF27AE60);
      case RoadmapTaskStatus.active:
        return const Color(0xFFD81B43);
      case RoadmapTaskStatus.locked:
        return const Color(0xFFBDBDBD);
    }
  }

  IconData _getNodeIcon(RoadmapNode node) {
    if (node.status == RoadmapTaskStatus.completed) {
      return Icons.check_rounded;
    }
    if (node.status == RoadmapTaskStatus.locked) {
      return Icons.lock_rounded;
    }
    if (node.icon is IconData) {
      return node.icon as IconData;
    }
    return Icons.play_arrow_rounded;
  }
}

// Keep alias RoadmapNodeWidget for backwards compatibility
typedef RoadmapNodeWidget = RoadmapTaskNode;
