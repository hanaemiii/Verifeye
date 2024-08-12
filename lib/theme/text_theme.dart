import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:verifeye/theme/colors.dart';

class AppTextTheme {
  static final primaryTextTheme = GoogleFonts.senTextTheme(
    const TextTheme(
      displayLarge: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w400,
        color: AppColors.black,
      ),
      displayMedium: TextStyle(
        fontSize: 27,
        fontWeight: FontWeight.w700,
        color: AppColors.black,
      ),
      displaySmall: TextStyle(
        fontSize: 27,
        fontWeight: FontWeight.w400,
        color: AppColors.black,
      ),
      headlineLarge: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w800,
        color: AppColors.black,
      ),
      headlineMedium: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: AppColors.black,
      ),
      headlineSmall: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w400,
        color: AppColors.black,
      ),
      bodyLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w800,
        color: AppColors.black,
      ),
      bodyMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.white,
      ),
      bodySmall: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: AppColors.black,
      ),
      labelLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.black,
      ),
      labelMedium: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w800,
        color: AppColors.black,
      ),
      labelSmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: AppColors.black,
      ),
    ),
  );
}
