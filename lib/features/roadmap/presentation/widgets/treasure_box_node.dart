import 'package:MatchIn/core/functions/show_image.dart';
import 'package:MatchIn/core/utils/app_assets.dart';
import 'package:MatchIn/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TreasureBoxNodeWidget extends StatefulWidget {
  const TreasureBoxNodeWidget({
    super.key,
    required this.milestoneIndex,
    required this.isUnlocked,
    required this.isClaimed,
    required this.onTap,
    this.circleKey,
  });

  final int milestoneIndex;
  final bool isUnlocked;
  final bool isClaimed;
  final VoidCallback onTap;
  final Key? circleKey;

  @override
  State<TreasureBoxNodeWidget> createState() => _TreasureBoxNodeWidgetState();
}

class _TreasureBoxNodeWidgetState extends State<TreasureBoxNodeWidget>
    with SingleTickerProviderStateMixin {
  bool _isPressed = false;
  late final AnimationController _pulseController;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _scaleAnimation = Tween<double>(begin: 0.96, end: 1.05).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    if (widget.isUnlocked && !widget.isClaimed) {
      _pulseController.repeat(reverse: true);
    }
  }

  @override
  void didUpdateWidget(covariant TreasureBoxNodeWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isUnlocked && !widget.isClaimed) {
      if (!_pulseController.isAnimating) {
        _pulseController.repeat(reverse: true);
      }
    } else {
      if (_pulseController.isAnimating) {
        _pulseController.stop();
        _pulseController.reset();
      }
    }
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

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
    final double boxSize = 72.r;
    final double depthHeight = 6.h;
    final double pressOffset = _isPressed ? 5.h : 0.0;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // 3D Interactive Treasure Box Button
        GestureDetector(
          onTapDown: _onTapDown,
          onTapUp: _onTapUp,
          onTapCancel: _onTapCancel,
          onTap: widget.onTap,
          behavior: HitTestBehavior.opaque,
          child: AnimatedBuilder(
            animation: _scaleAnimation,
            builder: (context, child) {
              final scale = (widget.isUnlocked && !widget.isClaimed)
                  ? _scaleAnimation.value
                  : 1.0;
              return Transform.scale(
                scale: scale,
                child: child,
              );
            },
            child: SizedBox(
              key: widget.circleKey,
              width: boxSize,
              height: boxSize + depthHeight,
              child: Stack(
                alignment: Alignment.topCenter,
                clipBehavior: Clip.none,
                children: [
                  // Glow background for unclaimed unlocked reward
                  if (widget.isUnlocked && !widget.isClaimed)
                    Positioned(
                      top: pressOffset,
                      child: Container(
                        width: boxSize + 12.r,
                        height: boxSize + 12.r,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xFFFFD700).withValues(alpha: 0.25),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFFFFD700).withValues(alpha: 0.4),
                              blurRadius: 14.r,
                              spreadRadius: 2.r,
                            ),
                          ],
                        ),
                      ),
                    ),

                  // 3D Bottom Depth Layer
                  Positioned(
                    top: depthHeight,
                    child: Container(
                      width: boxSize,
                      height: boxSize,
                      decoration: BoxDecoration(
                        color: widget.isClaimed
                            ? const Color(0xFF27AE60)
                            : widget.isUnlocked
                                ? const Color(0xFFD35400)
                                : const Color(0xFFBDBDBD),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: _isPressed ? 0.08 : 0.2),
                            blurRadius: _isPressed ? 2.r : 8.r,
                            offset: Offset(0, _isPressed ? 1.h : 4.h),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // 3D Top Face Container
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 100),
                    curve: Curves.easeOut,
                    top: pressOffset,
                    child: Container(
                      width: boxSize,
                      height: boxSize,
                      decoration: BoxDecoration(
                        color: widget.isClaimed
                            ? AppColors.success
                            : widget.isUnlocked
                                ? const Color(0xFFF39C12)
                                : AppColors.surfaceVariant,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: widget.isClaimed
                              ? Colors.white.withValues(alpha: 0.8)
                              : widget.isUnlocked
                                  ? const Color(0xFFFFE082)
                                  : AppColors.border.withValues(alpha: 0.4),
                          width: 2.w,
                        ),
                      ),
                      child: Center(
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(6.r),
                              child: showImage(
                                image: Assets.lottieTreasureBox,
                                width: 54.r,
                                height: 54.r,
                                fit: BoxFit.contain,
                              ),
                            ),
                            if (widget.isClaimed)
                              Positioned(
                                right: 2.r,
                                bottom: 2.r,
                                child: Container(
                                  padding: EdgeInsets.all(3.r),
                                  decoration: const BoxDecoration(
                                    color: AppColors.success,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.check_rounded,
                                    color: Colors.white,
                                    size: 14.r,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        SizedBox(height: 8.h),

        // Milestone Badge Label
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: widget.isClaimed
                ? AppColors.success.withValues(alpha: 0.15)
                : widget.isUnlocked
                    ? const Color(0xFFFFF3CD)
                    : AppColors.surfaceVariant,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: widget.isClaimed
                  ? AppColors.success.withValues(alpha: 0.4)
                  : widget.isUnlocked
                      ? const Color(0xFFFFEEBA)
                      : AppColors.border.withValues(alpha: 0.3),
              width: 1.w,
            ),
          ),
          child: Text(
            widget.isClaimed
                ? '+50 XP Claimed!'
                : widget.isUnlocked
                    ? '🎁 Claim +50 XP!'
                    : '🎁 +50 XP Milestone',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 12.sp,
              color: widget.isClaimed
                  ? AppColors.success
                  : widget.isUnlocked
                      ? const Color(0xFF856404)
                      : AppColors.textHint,
            ),
          ),
        ),
      ],
    );
  }
}
