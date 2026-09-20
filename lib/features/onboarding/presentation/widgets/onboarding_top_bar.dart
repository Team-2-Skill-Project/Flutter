import 'package:MatchIn/core/extensions/context_extensions.dart';
import 'package:MatchIn/features/onboarding/presentation/widgets/onboarding_indicator.dart';
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
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 12.h,
      ),
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
              color: context.colors.primary,
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
                        tapTargetSize: MaterialTapTargetSize
                            .shrinkWrap,
                      ),
                      child: Text(
                        context.l10n.skip,
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: context.colors.secondary,
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
