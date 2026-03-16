import 'package:flutter/material.dart';

abstract final class AppColors {
  static const Color background = Color(0xFF0A0A0F);
  static const Color surface = Color(0xFF141419);
  static const Color surfaceHigh = Color(0xFF1C1C24);
  static const Color accent = Color(0xFF7C6FFF);
  static const Color accentMuted = Color(0x407C6FFF);
  static const Color accentSubtle = Color(0x207C6FFF);
  static const Color textPrimary = Color(0xFFF0EDE8);
  static const Color textSecondary = Color(0xFF8A8694);
  static const Color textMuted = Color(0xFF4A4754);
  static const Color destructive = Color(0xFFFF6B6B);
  static const Color border = Color(0xFF1E1E28);
  static const Color ringTrack = Color(0xFF1E1E28);

  static const Color heatmap0 = Color(0xFF1E1E28);
  static const Color heatmap1 = Color(0xFF4A3FA0);
  static const Color heatmap2 = Color(0xFF6358CC);
  static const Color heatmap3 = Color(0xFF7C6FFF);
}

abstract final class AppSpacing {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
  static const double xxl = 48;
  static const double screenPadding = 28;
}

abstract final class AppRadius {
  static const double sm = 6;
  static const double md = 12;
  static const double full = 999;
}

abstract final class AppDurations {
  static const Duration fast = Duration(milliseconds: 150);
  static const Duration normal = Duration(milliseconds: 300);
  static const Duration slow = Duration(milliseconds: 600);
}
