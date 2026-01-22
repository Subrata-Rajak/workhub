import 'package:flutter/material.dart';

class AppColors {
  const AppColors._();

  static const Color primary = Color(0xFF2E6B66);
  static const Color secondary = Color(0xFF1F2937);

  // Backgrounds
  static const Color background = Color(0xFFF9FAFB);
  static const Color surface = Colors.white;
  static const Color surfaceAlt = Color(0xFFF3F4F6); // Light grey bg

  // Text
  static const Color textPrimary = Color(0xFF1F2937);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color textMuted = Color(0xFF9CA3AF);
  static const Color textInverse = Colors.white;

  // Borders
  static const Color border = Color(0xFFE5E7EB); // grey[200]
  static const Color borderFocus = primary;

  // Status
  static const Color success = Colors.green;
  static const Color warning = Colors.orange;
  static const Color error = Colors.red;
  static const Color info = Colors.blue;

  // Specific UI
  static final Color hoverOverlay = Colors.teal.withAlpha(26); // 0.1 opacity
  static final Color avatarBg = Colors.teal.withAlpha(26);
}
