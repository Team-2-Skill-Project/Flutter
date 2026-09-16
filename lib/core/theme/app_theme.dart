import 'package:flutter/material.dart';
import 'package:MatchIn/core/theme/dark_theme.dart';
import 'package:MatchIn/core/theme/light_theme.dart';

abstract final class AppTheme {
  AppTheme._();

  static ThemeData light({required Locale locale}) {
    return getLightTheme(
      isArabic: locale.languageCode == 'ar',
    );
  }

  static ThemeData dark({required Locale locale}) {
    return getDarkTheme(
      isArabic: locale.languageCode == 'ar',
    );
  }
}
