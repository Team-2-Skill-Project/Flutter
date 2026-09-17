import 'package:MatchIn/core/utils/app_colors.dart';
import 'package:MatchIn/features/onbording/presentation/widgets/onboarding_action_button.dart';
import 'package:MatchIn/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileSetupCard extends StatelessWidget {
  const ProfileSetupCard({
    super.key,
    required this.onStart,
    required this.onNotNow,
  });

  final VoidCallback onStart;
  final VoidCallback onNotNow;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: const Color(0xFFC4C6CF).withValues(alpha: 0.4),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Headline
          Text(
            S.of(context).setupCareerProfile,
            style: TextStyle(
              fontFamily: 'DM Sans',
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
              letterSpacing: -0.6,
              height: 30 / 24,
            ),
          ),
          SizedBox(height: 12.h),

          // 3 Clear Bullet Lines
          _buildBullet(
            dotColor: AppColors.secondary,
            text: S.of(context).onboardingBullet1,
          ),
          SizedBox(height: 10.h),
          _buildBullet(
            dotColor: AppColors.primary,
            text: S.of(context).onboardingBullet2,
          ),
          SizedBox(height: 10.h),
          _buildBullet(
            dotColor: AppColors.accent,
            text: S.of(context).onboardingBullet3,
          ),
          SizedBox(height: 16.h),

          // Primary Button: Start
          OnboardingActionButton(text: S.of(context).start, onPressed: onStart),
          SizedBox(height: 8.h),

          // Secondary Text Button: Not now
          Center(
            child: TextButton(
              onPressed: onNotNow,
              style: TextButton.styleFrom(
                minimumSize: Size(56.w, 36.h),
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              ),
              child: Text(
                S.of(context).notNow,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.secondary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBullet({required Color dotColor, required String text}) {
    return Row(
      children: [
        Container(
          width: 6.w,
          height: 6.w,
          decoration: BoxDecoration(color: dotColor, shape: BoxShape.circle),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.textSecondary,
              height: 19 / 14,
            ),
          ),
        ),
      ],
    );
  }
}
