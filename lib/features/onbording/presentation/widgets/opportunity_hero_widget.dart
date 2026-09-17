import 'package:MatchIn/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OpportunityHeroWidget extends StatelessWidget {
  const OpportunityHeroWidget({
    super.key,
    this.imagePath = 'assets/images/onb1_hero.png',
  });

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 326.w,
        height: 326.w,
        padding: EdgeInsets.all(8.w),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.6),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: const Color(0xFFC4C6CF).withValues(alpha: 0.6),
            width: 1,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16.r),
          child: Container(
            color: AppColors.greyBackground,
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return _buildFallback();
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFallback() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.background,
            AppColors.surfaceVariant.withValues(alpha: 0.5),
          ],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 90.w,
              height: 90.w,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.r),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.08),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Icon(
                Icons.auto_awesome_rounded,
                size: 42.sp,
                color: AppColors.primary,
              ),
            ),
            SizedBox(height: 16.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: AppColors.secondary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(
                  color: AppColors.secondary.withValues(alpha: 0.25),
                ),
              ),
              child: Text(
                'AI Career Matcher',
                style: TextStyle(
                  fontFamily: 'DM Sans',
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.secondary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
