import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:MatchIn/core/extensions/context_extensions.dart';
import 'package:MatchIn/core/utils/app_assets.dart';

class TreasureBoxNodeWidget extends StatefulWidget {
  const TreasureBoxNodeWidget({
    super.key,
    required this.milestoneIndex,
    required this.isUnlocked,
    required this.isClaimed,
    required this.onClaimSuccess,
    this.onLockedTap,
    this.circleKey,
  });

  final int milestoneIndex;
  final bool isUnlocked;
  final bool isClaimed;
  final VoidCallback onClaimSuccess;
  final VoidCallback? onLockedTap;
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
    _lottieController.value = widget.isClaimed ? 1.0 : 0.0;

    _lottieController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() => _isAnimating = false);
        widget.onClaimSuccess();
      }
    });
  }

  @override
  void didUpdateWidget(covariant TreasureBoxNodeWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!_isAnimating) {
      _lottieController.value = widget.isClaimed ? 1.0 : 0.0;
    }
  }

  @override
  void dispose() {
    _lottieController.dispose();
    super.dispose();
  }

  void _handleTap() {
    if (widget.isClaimed || _isAnimating) return;
    if (!widget.isUnlocked) {
      widget.onLockedTap?.call();
      return;
    }
    setState(() => _isAnimating = true);
    _lottieController.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    final double artworkSize = 74.r;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _TreasureBoxArtwork(
          artworkSize: artworkSize,
          circleKey: widget.circleKey,
          isUnlocked: widget.isUnlocked,
          isClaimed: widget.isClaimed,
          isAnimating: _isAnimating,
          controller: _lottieController,
          onTap: _handleTap,
        ),
        SizedBox(height: 6.h),
        _TreasureMilestoneBadge(
          isClaimed: widget.isClaimed,
          isUnlocked: widget.isUnlocked,
          onTap: _handleTap,
        ),
      ],
    );
  }
}

class _TreasureBoxArtwork extends StatelessWidget {
  const _TreasureBoxArtwork({
    required this.artworkSize,
    required this.circleKey,
    required this.isUnlocked,
    required this.isClaimed,
    required this.isAnimating,
    required this.controller,
    required this.onTap,
  });

  final double artworkSize;
  final Key? circleKey;
  final bool isUnlocked;
  final bool isClaimed;
  final bool isAnimating;
  final AnimationController controller;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        key: circleKey,
        width: artworkSize,
        height: artworkSize,
        alignment: Alignment.center,
        child: Stack(
          alignment: Alignment.center,
          children: [
            if (isUnlocked && !isClaimed && !isAnimating)
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
            Opacity(
              opacity: (!isUnlocked && !isClaimed) ? 0.7 : 1.0,
              child: Lottie.asset(
                Assets.lottieTreasureBox,
                controller: controller,
                width: artworkSize,
                height: artworkSize,
                fit: BoxFit.contain,
                animate: false,
                onLoaded: (composition) {
                  controller.duration = composition.duration;
                  if (isClaimed) {
                    controller.value = 1.0;
                  } else if (!isAnimating) {
                    controller.value = 0.0;
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TreasureMilestoneBadge extends StatelessWidget {
  const _TreasureMilestoneBadge({
    required this.isClaimed,
    required this.isUnlocked,
    required this.onTap,
  });

  final bool isClaimed;
  final bool isUnlocked;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textTheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
        decoration: BoxDecoration(
          color: isClaimed
              ? const Color(0xFF4F7A5A).withValues(alpha: 0.15)
              : isUnlocked
              ? const Color(0xFFFFF3CD)
              : colors.surfaceContainerHighest.withValues(alpha: 0.6),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isClaimed
                ? const Color(0xFF4F7A5A).withValues(alpha: 0.4)
                : isUnlocked
                ? const Color(0xFFFFD700)
                : colors.outline.withValues(alpha: 0.3),
            width: 1.w,
          ),
        ),
        child: Text(
          isClaimed
              ? '✅ +50 XP Collected!'
              : isUnlocked
              ? '🎁 Claim +50 XP!'
              : '🔒 +50 XP Milestone',
          style: textTheme.labelSmall?.copyWith(
            fontWeight: FontWeight.w700,
            fontSize: 12.sp,
            color: isClaimed
                ? const Color(0xFF4F7A5A)
                : isUnlocked
                ? const Color(0xFF856404)
                : colors.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}
