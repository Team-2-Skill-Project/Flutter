import 'package:MatchIn/core/utils/app_colors.dart';
import 'package:MatchIn/features/onbording/presentation/widgets/onboarding_indicator.dart';
import 'package:MatchIn/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingTopBar extends StatelessWidget {
  const OnboardingTopBar({
    super.key,
    required this.currentPage,
    required this.onSkip,
    this.totalSteps = 3,
  });

  final int currentPage;
  final VoidCallback onSkip;
  final int totalSteps;

  @override
  Widget build(BuildContext context) {
    final bool showSkip = currentPage < totalSteps - 1;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Brand Wordmark
          Text(
            'SkillMatch',
            style: TextStyle(
              fontFamily: 'DM Sans',
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.primary,
              letterSpacing: -0.45,
              height: 24 / 18,
            ),
          ),

          // Animated Indicator Dots
          OnboardingIndicator(
            currentPage: currentPage,
            itemCount: totalSteps,
          ),

          // Trailing Action: Skip
          SizedBox(
            width: 50.w,
            child: showSkip
                ? Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: onSkip,
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: Size(40.w, 24.h),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text(
                        S.of(context).skip,
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.secondary,
                          height: 20 / 14,
                        ),
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
