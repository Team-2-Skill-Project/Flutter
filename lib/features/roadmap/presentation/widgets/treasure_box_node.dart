import 'package:MatchIn/core/utils/app_assets.dart';
import 'package:MatchIn/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

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
  late final AnimationController _lottieController;
  bool _isAnimating = false;

  @override
  void initState() {
    super.initState();
    _lottieController = AnimationController(vsync: this);

    _lottieController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _isAnimating = false;
        });
        widget.onTap();
      }
    });
  }

  @override
  void dispose() {
    _lottieController.dispose();
    super.dispose();
  }

  void _handleTap() {
    if (widget.isClaimed || _isAnimating) {
      widget.onTap(); // Shows already collected notification
      return;
    }

    if (!widget.isUnlocked) {
      widget.onTap(); // Shows locked notification
      return;
    }

    // Unlocked and unclaimed: play animation ONCE
    setState(() {
      _isAnimating = true;
    });
    _lottieController.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    final double artworkSize = 74.r;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Standalone Treasure Box Artwork (No node circle, no circular container)
        GestureDetector(
          onTap: _handleTap,
          behavior: HitTestBehavior.opaque,
          child: Container(
            key: widget.circleKey, // Center point measured for path painter
            width: artworkSize,
            height: artworkSize,
            alignment: Alignment.center,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Subtle static golden glow indicator when ready to collect
                if (widget.isUnlocked && !widget.isClaimed && !_isAnimating)
                  Container(
                    width: artworkSize * 0.85,
                    height: artworkSize * 0.85,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFFFD700).withValues(alpha: 0.45),
                          blurRadius: 18.r,
                          spreadRadius: 4.r,
                        ),
                      ],
                    ),
                  ),

                // Pure Lottie Artwork (Controlled frame state)
                Opacity(
                  opacity: (!widget.isUnlocked && !widget.isClaimed) ? 0.7 : 1.0,
                  child: Lottie.asset(
                    Assets.lottieTreasureBox,
                    controller: _lottieController,
                    width: artworkSize,
                    height: artworkSize,
                    fit: BoxFit.contain,
                    onLoaded: (composition) {
                      _lottieController.duration = composition.duration;
                      if (widget.isClaimed) {
                        // Already collected: stay in OPEN state (1.0)
                        _lottieController.value = 1.0;
                      } else if (!_isAnimating) {
                        // Locked or Ready: stay in CLOSED state (0.0)
                        _lottieController.value = 0.0;
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),

        SizedBox(height: 6.h),

        // Independent Milestone Badge Label
        GestureDetector(
          onTap: _handleTap,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: widget.isClaimed
                  ? AppColors.success.withValues(alpha: 0.15)
                  : widget.isUnlocked
                      ? const Color(0xFFFFF3CD)
                      : AppColors.surfaceVariant.withValues(alpha: 0.6),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: widget.isClaimed
                    ? AppColors.success.withValues(alpha: 0.4)
                    : widget.isUnlocked
                        ? const Color(0xFFFFD700)
                        : AppColors.border.withValues(alpha: 0.3),
                width: 1.w,
              ),
            ),
            child: Text(
              widget.isClaimed
                  ? '✅ +50 XP Collected!'
                  : widget.isUnlocked
                      ? '🎁 Claim +50 XP!'
                      : '🔒 +50 XP Milestone',
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
        ),
      ],
    );
  }
}
