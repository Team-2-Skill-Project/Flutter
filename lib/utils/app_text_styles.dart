import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:MatchIn/utils/app_colors.dart';

abstract class AppTextStyles {
  // TODO: change these values

  static TextStyle extraBold24 = TextStyle(
    fontWeight: FontWeight.w800,
    fontSize: 24.sp,
    color: AppColors.textPrimary,
  );
  static TextStyle semiBold18 = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 18.sp,
    color: AppColors.textPrimary,
  );
  static TextStyle semiBold20 = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 20.sp,
    color: AppColors.onPrimary,
  );
  static TextStyle semiBold14 = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 14.sp,
    color: AppColors.textSecondary,
  );

  static TextStyle semiBold12 = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 12.sp,
    color: AppColors.onPrimary,
  );
  static TextStyle semiBold16 = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 16.sp,
    color: AppColors.textPrimary,
  );

  static TextStyle medium12 = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 12.sp,
    color: AppColors.textHint,
  );

  static TextStyle medium16 = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 16.sp,
    color: AppColors.onPrimary,
  );

  static TextStyle medium20 = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 20.sp,
    color: AppColors.textPrimary,
  );

  static TextStyle regular10 = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 10.sp,
    color: AppColors.textPrimary,
  );

  static TextStyle regular12 = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 12.sp,
    color: AppColors.primary,
  );

  static TextStyle regular14 = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 14.sp,
    color: AppColors.textSecondary,
  );

  static TextStyle bold36 = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 36.sp,
    color: AppColors.textPrimary,
  );
  static TextStyle bold16 = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 16.sp,
    color: AppColors.textPrimary,
  );

  static TextStyle light12 = TextStyle(
    fontWeight: FontWeight.w300,
    fontSize: 12.sp,
    color: AppColors.textPrimary,
  );
}
