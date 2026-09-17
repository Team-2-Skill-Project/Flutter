import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:MatchIn/core/utils/app_colors.dart';

abstract class AppTextStyles {
  // TODO: change these values

  static const String _arabicFont = 'Cairo';
  static const String _latinFont = 'Poppins';

  static String _font(bool isArabic) => isArabic ? _arabicFont : _latinFont;

  // ── Legacy static styles (kept for backward compat) ──────────────────────
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

  // ── Heading styles ────────────────────────────────────────────────────────

  static TextStyle heading24Bold({
    required bool isArabic,
    Color? color,
  }) =>
      TextStyle(
        fontFamily: _font(isArabic),
        fontSize: 24.sp,
        fontWeight: FontWeight.w700,
        color: color ?? AppColors.textPrimary,
      );

  static TextStyle heading18Bold({
    required bool isArabic,
    Color? color,
  }) =>
      TextStyle(
        fontFamily: _font(isArabic),
        fontSize: 18.sp,
        fontWeight: FontWeight.w700,
        color: color ?? AppColors.textPrimary,
      );

  // ── Body styles ───────────────────────────────────────────────────────────

  static TextStyle body14Bold({
    required bool isArabic,
    Color? color,
  }) =>
      TextStyle(
        fontFamily: _font(isArabic),
        fontSize: 14.sp,
        fontWeight: FontWeight.w700,
        color: color ?? AppColors.textPrimary,
      );

  static TextStyle body14SemiBold({
    required bool isArabic,
    Color? color,
  }) =>
      TextStyle(
        fontFamily: _font(isArabic),
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
        color: color ?? AppColors.textPrimary,
      );

  static TextStyle body14Regular({
    required bool isArabic,
    Color? color,
  }) =>
      TextStyle(
        fontFamily: _font(isArabic),
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        color: color ?? AppColors.textPrimary,
      );

  static TextStyle body12SemiBold({
    required bool isArabic,
    Color? color,
  }) =>
      TextStyle(
        fontFamily: _font(isArabic),
        fontSize: 12.sp,
        fontWeight: FontWeight.w600,
        color: color ?? AppColors.textPrimary,
      );

  static TextStyle body12Regular({
    required bool isArabic,
    Color? color,
  }) =>
      TextStyle(
        fontFamily: _font(isArabic),
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
        color: color ?? AppColors.textPrimary,
      );
}
