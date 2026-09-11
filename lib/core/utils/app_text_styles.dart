import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:MatchIn/core/utils/app_colors.dart';

abstract class AppTextStyles {
  // TODO: change these values

  static TextStyle semiBold20 = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 20.sp,
    color: AppColors.onPrimary,
  );

  static TextStyle regular14 = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 14.sp,
    color: AppColors.textSecondary,
  );
}
