import 'package:flutter/material.dart';

class AppColors {
  // Warm terracotta palette (sesuai mockup)
  static const Color primary = Color(0xFFD85A30);        // coral 600
  static const Color primaryLight = Color(0xFFFAECE7);   // coral 50
  static const Color primaryMid = Color(0xFFF5C4B3);     // coral 200
  static const Color primaryDark = Color(0xFF993C1D);    // coral 600 dark
  static const Color primaryDeep = Color(0xFF4A1B0C);    // coral 900

  // Neutrals
  static const Color background = Color(0xFFFAF7F3);     // warm cream
  static const Color surface = Color(0xFFFFFFFF);
  static const Color border = Color(0x1A000000);         // 10% black
  static const Color textPrimary = Color(0xFF1A1A1A);
  static const Color textSecondary = Color(0xFF5C5C5C);
  static const Color textTertiary = Color(0xFF8C8C8C);

  // Semantic
  static const Color success = Color(0xFF1D9E75);
  static const Color warning = Color(0xFFEF9F27);
  static const Color error = Color(0xFFE24B4A);
}

class AppTheme {
  static ThemeData light = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.light,
      primary: AppColors.primary,
      surface: AppColors.surface,
    ),
    scaffoldBackgroundColor: AppColors.background,
    fontFamily: 'SFPro', // ganti nanti kalau pakai custom font
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.w500, color: AppColors.textPrimary),
      displayMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.w500, color: AppColors.textPrimary),
      headlineMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: AppColors.textPrimary),
      bodyLarge: TextStyle(fontSize: 16, color: AppColors.textPrimary, height: 1.5),
      bodyMedium: TextStyle(fontSize: 14, color: AppColors.textPrimary, height: 1.5),
      bodySmall: TextStyle(fontSize: 12, color: AppColors.textSecondary, height: 1.5),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.primaryLight,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
      ),
    ),
  );
}