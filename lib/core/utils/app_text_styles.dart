import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:MatchIn/core/utils/app_constants.dart';

abstract final class AppTextStyles {
  AppTextStyles._();

  static TextTheme englishTextTheme() {
    return TextTheme(
      displayLarge: TextStyle(
        fontFamily: AppConstants.englishHeadingFont,
        fontSize: 40.sp,
        fontWeight: FontWeight.w700,
        height: 1.2,
      ),
      headlineLarge: TextStyle(
        fontFamily: AppConstants.englishHeadingFont,
        fontSize: 32.sp,
        fontWeight: FontWeight.w700,
        height: 1.2,
      ),
      headlineMedium: TextStyle(
        fontFamily: AppConstants.englishHeadingFont,
        fontSize: 24.sp,
        fontWeight: FontWeight.w700,
        height: 1.25,
      ),
      headlineSmall: TextStyle(
        fontFamily: AppConstants.englishHeadingFont,
        fontSize: 20.sp,
        fontWeight: FontWeight.w700,
        height: 1.3,
      ),
      titleLarge: TextStyle(
        fontFamily: AppConstants.englishHeadingFont,
        fontSize: 20.sp,
        fontWeight: FontWeight.w600,
      ),
      titleMedium: TextStyle(
        fontFamily: AppConstants.englishHeadingFont,
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
      ),
      titleSmall: TextStyle(
        fontFamily: AppConstants.englishHeadingFont,
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: TextStyle(
        fontFamily: AppConstants.englishBodyFont,
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
        height: 1.5,
      ),
      bodyMedium: TextStyle(
        fontFamily: AppConstants.englishBodyFont,
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        height: 1.5,
      ),
      bodySmall: TextStyle(
        fontFamily: AppConstants.englishBodyFont,
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
        height: 1.4,
      ),
      labelLarge: TextStyle(
        fontFamily: AppConstants.englishBodyFont,
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
      ),
      labelMedium: TextStyle(
        fontFamily: AppConstants.englishBodyFont,
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
      ),
      labelSmall: TextStyle(
        fontFamily: AppConstants.englishBodyFont,
        fontSize: 11.sp,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  static TextTheme arabicTextTheme() {
    return englishTextTheme().copyWith(
      displayLarge: englishTextTheme().displayLarge
          ?.copyWith(
            fontFamily: AppConstants.arabicHeadingFont,
          ),
      headlineLarge: englishTextTheme().headlineLarge
          ?.copyWith(
            fontFamily: AppConstants.arabicHeadingFont,
          ),
      headlineMedium: englishTextTheme().headlineMedium
          ?.copyWith(
            fontFamily: AppConstants.arabicHeadingFont,
          ),
      headlineSmall: englishTextTheme().headlineSmall
          ?.copyWith(
            fontFamily: AppConstants.arabicHeadingFont,
          ),
      titleLarge: englishTextTheme().titleLarge?.copyWith(
        fontFamily: AppConstants.arabicHeadingFont,
      ),
      titleMedium: englishTextTheme().titleMedium?.copyWith(
        fontFamily: AppConstants.arabicHeadingFont,
      ),
      titleSmall: englishTextTheme().titleSmall?.copyWith(
        fontFamily: AppConstants.arabicHeadingFont,
      ),
      bodyLarge: englishTextTheme().bodyLarge?.copyWith(
        fontFamily: AppConstants.arabicBodyFont,
      ),
      bodyMedium: englishTextTheme().bodyMedium?.copyWith(
        fontFamily: AppConstants.arabicBodyFont,
      ),
      bodySmall: englishTextTheme().bodySmall?.copyWith(
        fontFamily: AppConstants.arabicBodyFont,
      ),
      labelLarge: englishTextTheme().labelLarge?.copyWith(
        fontFamily: AppConstants.arabicBodyFont,
      ),
      labelMedium: englishTextTheme().labelMedium?.copyWith(
        fontFamily: AppConstants.arabicBodyFont,
      ),
      labelSmall: englishTextTheme().labelSmall?.copyWith(
        fontFamily: AppConstants.arabicBodyFont,
      ),
    );
  }
}
