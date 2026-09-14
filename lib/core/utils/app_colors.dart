import 'package:flutter/material.dart';

abstract class AppColors {
  // Primary Brand
  static const Color primary = Color(0xFF1F365C); // Midnight Blue
  static const Color onPrimary = Color(0xFFFFFFFF);

  // Secondary
  static const Color secondary = Color(0xFFD06B4F); // Terracotta
  static const Color onSecondary = Color(0xFFFFFFFF);

  // Accent
  static const Color accent = Color(0xFFD4A72C); // Golden Mustard

  // Backgrounds
  static const Color background = Color(0xFFFAF8F4); // Warm Cream
  static const Color greyBackground = Color(0xFFF2EFE9);
  static const Color surface = Color(0xFFFFFFFF); // White
  static const Color surfaceVariant = Color(0xFFE5E1DA);

  // Text Colors
  static const Color textPrimary = Color(0xFF222831); // Ink
  static const Color textSecondary = Color(0xFF707780); // Muted Gray
  static const Color textHint = Color(0xFF707780);

  // Borders & Divider
  static const Color border = Color(0xFFE5E1DA); // Warm Gray
  static const Color divider = Color(0xFFE5E1DA);

  // Status Colors
  static const Color success = Color(0xFF4F7A5A); // Forest Green
  static const Color warning = Color(0xFFC88A26); // Amber
  static const Color error = Color(0xFFB85450); // Muted Red
  static const Color info = Color(0xFF1F365C);
}
