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
    if (widget.node.status == RoadmapTaskStatus.locked) return;
    setState(() {
      _isPressed = true;
    });
  }

  void _onTapUp(TapUpDetails details) {
    if (widget.node.status == RoadmapTaskStatus.locked) return;
    setState(() {
      _isPressed = false;
    });
  }

  void _onTapCancel() {
    if (widget.node.status == RoadmapTaskStatus.locked) return;
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

    // Proportional node surface sizes
    final double circleSize = isActive
        ? 76.r
        : isCompleted
        ? 68.r
        : 64.r;

    // 3D Depth heights
    final double depthHeight = isActive
        ? 14.h
        : isCompleted
        ? 9.h
        : 4.h;

    // Press translation (compresses depth down on tap)
    final double pressTranslation = _isPressed
        ? (isActive ? 11.h : depthHeight - 2.h)
        : 0.0;

    final baseColor = _getNodeColor(status);
    final depthColor = _getDepthColor(status);
    final iconColor = isLocked ? AppColors.textHint : Colors.white;

    // Proportional outer ring parameters
    final double ringSize = 84.r;
    final double totalWidth = isActive ? ringSize : circleSize;
    final double ringOffset = isActive ? (ringSize - circleSize) / 2 : 0.0;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // START indicator bubble for ACTIVE task
        if (isActive) ...[const ActiveTaskIndicator(), SizedBox(height: 10.h)],

        // Physical 3D Pressable Node Button Stack
        GestureDetector(
          onTapDown: _onTapDown,
          onTapUp: _onTapUp,
          onTapCancel: _onTapCancel,
          onTap: widget.onTap,
          behavior: HitTestBehavior.opaque,
          child: SizedBox(
            key: widget.circleKey,
            width: totalWidth,
            height: (isActive ? ringSize : circleSize) + depthHeight,
            child: Stack(
              alignment: Alignment.topCenter,
              clipBehavior: Clip.none,
              children: [
                // Proportional outer ring background for ACTIVE task
                if (isActive)
                  Positioned(
                    top: pressTranslation,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 80),
                      width: ringSize,
                      height: ringSize,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.primary.withValues(alpha: 0.35),
                          width: 3.5.w,
                        ),
                      ),
                    ),
                  ),

                // 1. Bottom 3D Depth Layer (Solid dark contrast base block)
                Positioned(
                  top: ringOffset + depthHeight,
                  child: Container(
                    width: circleSize,
                    height: circleSize,
                    decoration: BoxDecoration(
                      color: depthColor,
                      shape: BoxShape.circle,
                      border: isActive
                          ? Border.all(
                              color: const Color(0xFF7F0000),
                              width: 1.5.w,
                            )
                          : null,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(
                            alpha: _isPressed ? 0.08 : 0.26,
                          ),
                          blurRadius: _isPressed ? 2.r : 10.r,
                          offset: Offset(0, _isPressed ? 1.h : 6.h),
                        ),
                      ],
                    ),
                  ),
                ),

                // 2. Top Button Surface (Translates down on tap, compressing depth)
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 80),
                  curve: Curves.easeOutCubic,
                  top: ringOffset + pressTranslation,
                  child: Container(
                    width: circleSize,
                    height: circleSize,
                    decoration: BoxDecoration(
                      color: baseColor,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isLocked
                            ? AppColors.border.withValues(alpha: 0.4)
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
                        _getNodeIcon(widget.node),
                        color: iconColor,
                        size: isActive
                            ? 34.r
                            : isCompleted
                            ? 32.r
                            : 26.r,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        SizedBox(height: 14.h),

        // Node Title
        SizedBox(
          width: 140.w,
          child: Text(
            widget.node.title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: isActive ? 15.sp : 14.sp,
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
        return AppColors.success; // 0xFF2ECC71
      case RoadmapTaskStatus.active:
        return AppColors.primary; // 0xFFF83758
      case RoadmapTaskStatus.locked:
        return AppColors.surfaceVariant;
    }
  }

  Color _getDepthColor(RoadmapTaskStatus status) {
    switch (status) {
      case RoadmapTaskStatus.completed:
        return const Color(0xFF196F3D); // Dark forest green base
      case RoadmapTaskStatus.active:
        return const Color(0xFFB71C1C); // Solid rich dark crimson red base
      case RoadmapTaskStatus.locked:
        return const Color(0xFF9E9E9E); // Solid grey base
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
