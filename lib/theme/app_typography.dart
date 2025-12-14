import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppFontFamilies {
  static const String primary = 'Geist';
  static const String secondary = 'Charter';
  static const String devanagari = 'Noto Sans Devanagari';
  static const String bengali = 'Noto Sans Bengali UI';
  static const String gujarati = 'Noto Sans Gujarati';
  static const String kannada = 'Noto Sans Kannada';
  static const String malayalam = 'Noto Sans Malayalam';
  static const String tamil = 'Noto Sans Tamil';
  static const String oriya = 'Noto Sans Oriya';
  static const String telugu = 'Noto Sans Telugu';
}

class AppTypography {
  // Font Sizes
  static const double size0 = 12.0;
  static const double size1 = 14.0;
  static const double size2 = 16.0;
  static const double size3 = 20.0;
  static const double size4 = 24.0;
  static const double size5 = 42.0;

  // Body Styles
  static const TextStyle bodyMicro = TextStyle(
    fontFamily: AppFontFamilies.primary,
    fontWeight: FontWeight.w400,
    fontSize: size0,
    color: AppColors.black,
  );

  static const TextStyle bodyMicroSemibold = TextStyle(
    fontFamily: AppFontFamilies.primary,
    fontWeight: FontWeight.w600,
    fontSize: size0,
    color: AppColors.black,
  );

  static const TextStyle bodySmall = TextStyle(
    fontFamily: AppFontFamilies.primary,
    fontWeight: FontWeight.w400,
    fontSize: size1,
    color: AppColors.black,
  );

  static const TextStyle bodySmallSemibold = TextStyle(
    fontFamily: AppFontFamilies.primary,
    fontWeight: FontWeight.w600,
    fontSize: size1,
    color: AppColors.black,
  );

  static const TextStyle bodyRegular = TextStyle(
    fontFamily: AppFontFamilies.primary,
    fontWeight: FontWeight.w400,
    fontSize: size2,
    color: AppColors.black,
  );

  static const TextStyle bodyRegularSemibold = TextStyle(
    fontFamily: AppFontFamilies.primary,
    fontWeight: FontWeight.w600,
    fontSize: size2,
    color: AppColors.black,
  );

  static const TextStyle bodyLarge = TextStyle(
    fontFamily: AppFontFamilies.secondary,
    fontWeight: FontWeight.w400,
    fontSize: size3,
    color: AppColors.black,
  );

  static const TextStyle bodyLargeBold = TextStyle(
    fontFamily: AppFontFamilies.secondary,
    fontWeight: FontWeight.w700,
    fontSize: size3,
    color: AppColors.black,
  );

  // Headings
  static const TextStyle heading1 = TextStyle(
    fontFamily: AppFontFamilies.primary,
    fontWeight: FontWeight.w700,
    fontSize: size5,
    color: AppColors.black,
  );

  static const TextStyle heading2 = TextStyle(
    fontFamily: AppFontFamilies.primary,
    fontWeight: FontWeight.w600,
    fontSize: size4,
    color: AppColors.black,
  );

  static const TextStyle heading3 = TextStyle(
    fontFamily: AppFontFamilies.primary,
    fontWeight: FontWeight.w600,
    fontSize: size3,
    color: AppColors.black,
  );

  // Links
  static const TextStyle microLink = TextStyle(
    fontFamily: AppFontFamilies.primary,
    fontWeight: FontWeight.w400,
    fontSize: size0,
    decoration: TextDecoration.underline,
    color: AppColors.blue500, // Assuming link color
  );
  
  static const TextStyle regularLink = TextStyle(
    fontFamily: AppFontFamilies.primary,
    fontWeight: FontWeight.w400,
    fontSize: size2,
    decoration: TextDecoration.underline,
    color: AppColors.blue500,
  );
}
