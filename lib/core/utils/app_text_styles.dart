import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:MatchIn/core/utils/app_constants.dart';

abstract final class AppTextStyles {
  AppTextStyles._();

  // =========================================================
  // Heading Fonts
  // English → DM Sans
  // Arabic  → Alexandria
  // =========================================================

  static TextStyle heading24Bold({required bool isArabic, Color? color}) {
    return TextStyle(
      fontFamily: _headingFont(isArabic),
      fontSize: 24.sp,
      fontWeight: FontWeight.w700,
      color: color,
    );
  }

  static TextStyle heading18Bold({required bool isArabic, Color? color}) {
    return TextStyle(
      fontFamily: _headingFont(isArabic),
      fontSize: 18.sp,
      fontWeight: FontWeight.w700,
      color: color,
    );
  }

  static TextStyle heading18SemiBold({required bool isArabic, Color? color}) {
    return TextStyle(
      fontFamily: _headingFont(isArabic),
      fontSize: 18.sp,
      fontWeight: FontWeight.w600,
      color: color,
    );
  }

  static TextStyle heading16Bold({required bool isArabic, Color? color}) {
    return TextStyle(
      fontFamily: _headingFont(isArabic),
      fontSize: 16.sp,
      fontWeight: FontWeight.w700,
      color: color,
    );
  }

  static TextStyle heading16SemiBold({required bool isArabic, Color? color}) {
    return TextStyle(
      fontFamily: _headingFont(isArabic),
      fontSize: 16.sp,
      fontWeight: FontWeight.w600,
      color: color,
    );
  }

  static TextStyle heading14Bold({required bool isArabic, Color? color}) {
    return TextStyle(
      fontFamily: _headingFont(isArabic),
      fontSize: 14.sp,
      fontWeight: FontWeight.w700,
      color: color,
    );
  }

  static TextStyle heading14SemiBold({required bool isArabic, Color? color}) {
    return TextStyle(
      fontFamily: _headingFont(isArabic),
      fontSize: 14.sp,
      fontWeight: FontWeight.w600,
      color: color,
    );
  }

  static TextStyle heading12Bold({required bool isArabic, Color? color}) {
    return TextStyle(
      fontFamily: _headingFont(isArabic),
      fontSize: 12.sp,
      fontWeight: FontWeight.w700,
      color: color,
    );
  }

  static TextStyle heading12SemiBold({required bool isArabic, Color? color}) {
    return TextStyle(
      fontFamily: _headingFont(isArabic),
      fontSize: 12.sp,
      fontWeight: FontWeight.w600,
      color: color,
    );
  }

  // =========================================================
  // Body / UI Fonts
  // English → Inter
  // Arabic  → Tajawal
  // =========================================================

  static TextStyle body16Bold({required bool isArabic, Color? color}) {
    return TextStyle(
      fontFamily: _bodyFont(isArabic),
      fontSize: 16.sp,
      fontWeight: FontWeight.w700,
      color: color,
    );
  }

  static TextStyle body16SemiBold({required bool isArabic, Color? color}) {
    return TextStyle(
      fontFamily: _bodyFont(isArabic),
      fontSize: 16.sp,
      fontWeight: FontWeight.w600,
      color: color,
    );
  }

  static TextStyle body16Regular({required bool isArabic, Color? color}) {
    return TextStyle(
      fontFamily: _bodyFont(isArabic),
      fontSize: 16.sp,
      fontWeight: FontWeight.w400,
      color: color,
    );
  }

  static TextStyle body14Bold({required bool isArabic, Color? color}) {
    return TextStyle(
      fontFamily: _bodyFont(isArabic),
      fontSize: 14.sp,
      fontWeight: FontWeight.w700,
      color: color,
    );
  }

  static TextStyle body14SemiBold({required bool isArabic, Color? color}) {
    return TextStyle(
      fontFamily: _bodyFont(isArabic),
      fontSize: 14.sp,
      fontWeight: FontWeight.w600,
      color: color,
    );
  }

  static TextStyle body14Regular({required bool isArabic, Color? color}) {
    return TextStyle(
      fontFamily: _bodyFont(isArabic),
      fontSize: 14.sp,
      fontWeight: FontWeight.w400,
      color: color,
    );
  }

  static TextStyle body12Bold({required bool isArabic, Color? color}) {
    return TextStyle(
      fontFamily: _bodyFont(isArabic),
      fontSize: 12.sp,
      fontWeight: FontWeight.w700,
      color: color,
    );
  }

  static TextStyle body12SemiBold({required bool isArabic, Color? color}) {
    return TextStyle(
      fontFamily: _bodyFont(isArabic),
      fontSize: 12.sp,
      fontWeight: FontWeight.w600,
      color: color,
    );
  }

  static TextStyle body12Regular({required bool isArabic, Color? color}) {
    return TextStyle(
      fontFamily: _bodyFont(isArabic),
      fontSize: 12.sp,
      fontWeight: FontWeight.w400,
      color: color,
    );
  }

  // =========================================================
  // Font Family Helpers
  // =========================================================

  static String _headingFont(bool isArabic) {
    return isArabic
        ? AppConstants.arabicHeadingFont
        : AppConstants.englishHeadingFont;
  }

  static String _bodyFont(bool isArabic) {
    return isArabic
        ? AppConstants.arabicBodyFont
        : AppConstants.englishBodyFont;
  }

  static TextTheme textTheme({required bool isArabic}) {
    return TextTheme(
      headlineLarge: heading24Bold(isArabic: isArabic),
      headlineMedium: heading18Bold(isArabic: isArabic),
      headlineSmall: heading18SemiBold(isArabic: isArabic),

      titleLarge: heading16Bold(isArabic: isArabic),
      titleMedium: heading14Bold(isArabic: isArabic),
      titleSmall: heading12SemiBold(isArabic: isArabic),

      bodyLarge: body16Regular(isArabic: isArabic),
      bodyMedium: body14Regular(isArabic: isArabic),
      bodySmall: body12Regular(isArabic: isArabic),

      labelLarge: body16SemiBold(isArabic: isArabic),
      labelMedium: body14SemiBold(isArabic: isArabic),
      labelSmall: body12SemiBold(isArabic: isArabic),
    );
  }
}
