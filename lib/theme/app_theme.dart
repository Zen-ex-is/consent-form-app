import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_typography.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: AppColors.blue500,
      scaffoldBackgroundColor: AppColors.white,
      colorScheme: const ColorScheme.light(
        primary: AppColors.blue500,
        secondary: AppColors.blue300,
        surface: AppColors.white,
        error: Colors.red, // Default error color
        onPrimary: AppColors.white,
        onSecondary: AppColors.black,
        onSurface: AppColors.black,
        onError: AppColors.white,
      ),
      textTheme: const TextTheme(
        displayLarge: AppTypography.heading1,
        displayMedium: AppTypography.heading2,
        bodyLarge: AppTypography.bodyLarge,
        bodyMedium: AppTypography.bodyRegular,
        bodySmall: AppTypography.bodySmall,
        labelSmall: AppTypography.bodyMicro,
      ),
      // Add more theme customizations here based on global.json if needed
    );
  }
}
