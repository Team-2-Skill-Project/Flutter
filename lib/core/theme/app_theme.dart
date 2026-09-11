// ignore_for_file: library_prefixes

import 'package:flutter/material.dart';
import 'package:skill_match/core/theme/dark_theme.dart' as DarkTheme;
import 'package:skill_match/core/theme/light_theme.dart' as LightTheme;

abstract class AppTheme {
  static ThemeData get lightTheme => LightTheme.lightTheme;
  static ThemeData get darkTheme => DarkTheme.darkTheme;
}
