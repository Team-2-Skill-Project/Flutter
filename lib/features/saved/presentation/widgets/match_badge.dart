import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:MatchIn/core/utils/app_colors.dart';
import 'package:MatchIn/features/saved/presentation/models/saved_job_ui_model.dart';

class MatchBadge extends StatelessWidget {
  const MatchBadge({
    super.key,
    required this.matchLevel,
  });

  final MatchLevel matchLevel;

  @override
  Widget build(BuildContext context) {
    final isStrong = matchLevel == MatchLevel.strong;
    final color = isStrong ? AppColors.success : AppColors.amber;
    final bgColor = isStrong
        ? const Color(0x1A4F7A5A) // rgba(79, 122, 90, 0.1)
        : const Color(0x1AC88A26); // rgba(200, 138, 38, 0.1)
    final label = isStrong ? 'Strong Match' : 'Good Match';

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 6.w,
            height: 6.w,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 6.w),
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 11.sp,
              fontWeight: FontWeight.w600,
              color: color,
              height: 16 / 11,
            ),
          ),
        ],
      ),
    );
  }
}
