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
  });

  final RoadmapNode node;
  final VoidCallback onTap;

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
    final iconColor = isLocked ? AppColors.textHint : Colors.white;

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
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 120),
            curve: Curves.easeOut,
            transform: Matrix4.translationValues(0, _isPressed ? 4.0.h : 0.0, 0),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Extra circular ring outline for ACTIVE task
                if (isActive)
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 120),
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

                // Main Circular Task Node
                AnimatedContainer(
                  duration: const Duration(milliseconds: 120),
                  width: 68.r,
                  height: 68.r,
                  decoration: BoxDecoration(
                    color: baseColor,
                    shape: BoxShape.circle,
                    border: isLocked
                        ? Border.all(color: AppColors.border.withValues(alpha: 0.5), width: 2.w)
                        : null,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: _isPressed ? 0.08 : 0.20),
                        blurRadius: _isPressed ? 2.r : 8.r,
                        offset: Offset(0, _isPressed ? 2.h : 6.h),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Icon(
                      _getNodeIcon(widget.node),
                      color: iconColor,
                      size: isCompleted ? 32.r : 28.r,
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
