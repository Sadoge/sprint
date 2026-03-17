import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'tokens.dart';

abstract final class AppTypography {
  // Syne styles
  static TextStyle get displayLarge => GoogleFonts.syne(
    fontSize: 52,
    fontWeight: FontWeight.w800,
    color: AppColors.textPrimary,
  );

  static TextStyle get displayMedium => GoogleFonts.syne(
    fontSize: 46,
    fontWeight: FontWeight.w800,
    color: AppColors.textPrimary,
  );

  static TextStyle get headingLarge => GoogleFonts.syne(
    fontSize: 28,
    fontWeight: FontWeight.w800,
    color: AppColors.textPrimary,
  );

  static TextStyle get screenTitle => GoogleFonts.syne(
    fontSize: 24,
    fontWeight: FontWeight.w800,
    color: AppColors.textPrimary,
  );

  static TextStyle get statValue => GoogleFonts.syne(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  static TextStyle get brand => GoogleFonts.syne(
    fontSize: 14,
    fontWeight: FontWeight.w800,
    letterSpacing: 3,
    color: AppColors.textPrimary,
  );

  // DM Mono styles
  static TextStyle get countdown => GoogleFonts.dmMono(
    fontSize: 46,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
  );

  static TextStyle get pillText => GoogleFonts.dmMono(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
  );

  static TextStyle get pillTextActive => GoogleFonts.dmMono(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.accent,
  );

  static TextStyle get monoMedium => GoogleFonts.dmMono(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );

  static TextStyle get mono => GoogleFonts.dmMono(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );

  static TextStyle get labelSmall => GoogleFonts.dmMono(
    fontSize: 11,
    fontWeight: FontWeight.w600,
    letterSpacing: 2,
    color: AppColors.textSecondary,
  );

  static TextStyle get labelTiny => GoogleFonts.dmMono(
    fontSize: 10,
    fontWeight: FontWeight.w600,
    letterSpacing: 1,
    color: AppColors.textPrimary,
  );

  static TextStyle get labelTinyInactive => GoogleFonts.dmMono(
    fontSize: 10,
    fontWeight: FontWeight.w500,
    letterSpacing: 1,
    color: AppColors.textMuted,
  );

  static TextStyle get brandSubtitle => GoogleFonts.dmMono(
    fontSize: 11,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );

  static TextStyle get sprintCount => GoogleFonts.dmMono(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
  );

  static TextStyle get resetButton => GoogleFonts.dmMono(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: AppColors.destructive,
  );

  // Inter styles
  static TextStyle get settingTitle => GoogleFonts.inter(
    fontSize: 15,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
  );
}
