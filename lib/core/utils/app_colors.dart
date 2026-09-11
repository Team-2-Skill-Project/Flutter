import 'package:flutter/material.dart';

abstract class AppColors {
  // TODO: change these values

  // Primary Brand
  static const Color primary = Color(0xFFF83758);
  static const Color onPrimary = Color(0xFFFFFFFF);

  // Secondary
  static const Color secondary = Color(0xFF1F2A44);
  static const Color onSecondary = Color(0xFFFFFFFF);

  // Backgrounds
  static const Color background = Color(0xFFFFFFFF);
  static const Color greyBackground = Color.fromARGB(243, 253, 253, 253);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF0F0F0);

  // Text Colors
  static const Color textPrimary = Color(0xFF000000);
  static const Color textSecondary = Color(0xFF575757);
  static const Color textHint = Color(0xFF676767);

  // Borders & Divider
  static const Color border = Color(0xFFA8A8A9);
  static const Color divider = Color(0xFFE5E5E5);

  // Status Colors
  static const Color success = Color(0xFF2ECC71);
  static const Color warning = Color(0xFFF39C12);
  static const Color error = Color(0xFFE53935);
  static const Color info = Color(0xFF2196F3);
}
