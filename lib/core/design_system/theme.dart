import 'package:flutter/material.dart';
import 'tokens.dart';

final sprintDarkTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: AppColors.background,
  colorScheme: const ColorScheme.dark(
    primary: AppColors.accent,
    surface: AppColors.surface,
    onPrimary: AppColors.background,
    onSurface: AppColors.textPrimary,
  ),
  cardColor: AppColors.surface,
  dividerColor: AppColors.border,
  splashColor: AppColors.accentSubtle,
  highlightColor: AppColors.accentSubtle,
);
