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

  // ==============================================================
  // PRESS HANDLERS
  // ==============================================================

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

    // ============================================================
    // NODE SIZE
    // ============================================================

    final double circleSize = isActive
        ? 76.r
        : isCompleted
        ? 68.r
        : 64.r;

    // ============================================================
    // 3D DEPTH
    // ============================================================

    final double depthHeight = isActive
        ? 14.h
        : isCompleted
        ? 9.h
        : 4.h;

    // ============================================================
    // PRESS TRANSLATION
    //
    // The top surface moves down when pressed.
    // ============================================================

    final double pressTranslation = _isPressed
        ? (isActive ? 11.h : depthHeight - 2.h)
        : 0.0;

    // ============================================================
    // COLORS
    // ============================================================

    final Color baseColor = _getNodeColor(status);
    final Color depthColor = _getDepthColor(status);

    final Color iconColor = isLocked ? AppColors.textSecondary : Colors.white;

    // ============================================================
    // ACTIVE RING
    //
    // The ring surrounds ONLY the top surface.
    //
    // Active node = 76.r
    // Ring        = 84.r
    //
    // Difference = 8.r
    // So there is approximately 4.r around each side.
    // ============================================================

    final double ringSize = isActive ? 84.r : circleSize;

    // Centers the 76.r node inside the 84.r ring.
    final double ringOffset = isActive ? (ringSize - circleSize) / 2 : 0.0;

    // Width required by the largest element.
    final double totalWidth = isActive ? ringSize : circleSize;

    // ============================================================
    // NODE AREA HEIGHT
    //
    // Ring/node + 3D depth.
    // ============================================================

    final double nodeAreaHeight =
        (isActive ? ringSize : circleSize) + depthHeight;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // ============================================================
        // START INDICATOR
        // ============================================================
        if (isActive) ...[const ActiveTaskIndicator(), SizedBox(height: 10.h)],

        // ============================================================
        // PRESSABLE ROADMAP NODE
        // ============================================================
        GestureDetector(
          onTapDown: _onTapDown,
          onTapUp: _onTapUp,
          onTapCancel: _onTapCancel,
          onTap: widget.onTap,
          behavior: HitTestBehavior.opaque,
          child: SizedBox(
            key: widget.circleKey,
            width: totalWidth,
            height: nodeAreaHeight,
            child: Stack(
              alignment: Alignment.topCenter,
              clipBehavior: Clip.none,
              children: [
                // ======================================================
                // ACTIVE OUTER RING
                //
                // The ring follows the top surface.
                //
                // It uses the exact same vertical translation as
                // the top node surface so it stays centered while
                // pressing.
                // ======================================================
                if (isActive)
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 80),
                    curve: Curves.easeOutCubic,
                    top: ringOffset + pressTranslation,
                    left: 0,
                    right: 0,
                    child: IgnorePointer(
                      child: Container(
                        width: ringSize,
                        height: ringSize,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.primary.withValues(alpha: 0.30),
                            width: 3.w,
                          ),
                        ),
                      ),
                    ),
                  ),

                // ======================================================
                // 3D DEPTH LAYER
                //
                // This remains below the top surface.
                //
                // When the button is idle:
                //
                //       TOP
                //       ↓
                //      NODE
                //       ↓
                //     DEPTH
                //
                // When pressed, the top surface moves toward the
                // depth layer and visually compresses the button.
                // ======================================================
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

                // ======================================================
                // TOP BUTTON SURFACE
                //
                // This is the visible roadmap node.
                //
                // It moves down when pressed.
                // ======================================================
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

        // ============================================================
        // SPACE BETWEEN NODE AND TITLE
        // ============================================================
        SizedBox(height: 14.h),

        // ============================================================
        // NODE TITLE
        // ============================================================
        SizedBox(
          width: 140.w,
          child: Text(
            widget.node.title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: isActive ? 15.sp : 14.sp,
              color: isLocked ? AppColors.textSecondary : AppColors.secondary,
            ),
          ),
        ),

        // ============================================================
        // NODE SUBTITLE
        // ============================================================
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
                    ? AppColors.textSecondary.withValues(alpha: 0.7)
                    : AppColors.textSecondary,
              ),
            ),
          ),
        ],
      ],
    );
  }

  // ==============================================================
  // NODE COLOR
  // ==============================================================

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

  // ==============================================================
  // 3D DEPTH COLOR
  // ==============================================================

  Color _getDepthColor(RoadmapTaskStatus status) {
    switch (status) {
      case RoadmapTaskStatus.completed:
        return const Color(0xFF196F3D);

      case RoadmapTaskStatus.active:
        return const Color(0xFFB71C1C);

      case RoadmapTaskStatus.locked:
        return const Color(0xFF9E9E9E);
    }
  }

  // ==============================================================
  // NODE ICON
  // ==============================================================

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

// Keep alias RoadmapNodeWidget for backwards compatibility.
typedef RoadmapNodeWidget = RoadmapTaskNode;
