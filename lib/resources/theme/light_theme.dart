import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'fonts.dart';

ThemeData lightTheme() {
  return ThemeData(
    useMaterial3: false,
    fontFamily: AppFonts.euclid,
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
          fontWeight: FontWeight.w800,
          fontSize: 28,
          color: AppColors.gold5,
          letterSpacing: 0.25),
      headlineMedium: TextStyle(
          fontWeight: FontWeight.w800,
          fontSize: 24,
          color: AppColors.gold5,
          letterSpacing: 0.25),

      headlineSmall: TextStyle(
          color: AppColors.gold5,
          fontWeight: FontWeight.w500,
          fontSize: 18,
          letterSpacing: 0.25),

      titleLarge: TextStyle(
          fontWeight: FontWeight.w600, fontSize: 24, color: Colors.black),
      titleMedium: TextStyle(
          fontWeight: FontWeight.w600, fontSize: 20, color: Colors.black),
      titleSmall: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 16,
        color: Colors.black,
        //height: 0.08,
        letterSpacing: 0.32,
      ),
      //bodyEmphasized = bodyLarge
      bodyLarge: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 14,
        color: AppColors.neutral6,
      ),
      // body = bodymedium
      bodyMedium: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 14,
          color: AppColors.neutral9_5),

      bodySmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: AppColors.neutral6,
          letterSpacing: 0.18),
      //body small emphasized = display medium
      displaySmall: TextStyle(
          fontWeight: FontWeight.w600, fontSize: 12, color: Colors.black),
    ),
  );
}
