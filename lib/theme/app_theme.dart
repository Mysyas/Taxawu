import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.blanc,
      primaryColor: AppColors.vertFonce,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.vertFonce,
        primary: AppColors.vertFonce,
        secondary: AppColors.orange,
        surface: AppColors.blanc,
      ),
      textTheme: TextTheme(
        displayLarge: GoogleFonts.fredoka(
          fontSize: 32,
          fontWeight: FontWeight.w600,
          color: AppColors.blanc,
        ),
        headlineLarge: GoogleFonts.fredoka(
          fontSize: 26,
          fontWeight: FontWeight.bold,
          color: AppColors.vertFonce,
        ),
        headlineMedium: GoogleFonts.fredoka(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: AppColors.vertFonce,
        ),
        titleLarge: GoogleFonts.fredoka(
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        bodyLarge: GoogleFonts.montserrat(
          fontSize: 16,
          color: AppColors.noir,
        ),
        bodyMedium: GoogleFonts.montserrat(
          fontSize: 11,
          color: AppColors.gris,
        ),
        labelLarge: GoogleFonts.montserrat(
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.vertOlive,
          foregroundColor: AppColors.blanc,
          textStyle: GoogleFonts.montserrat(fontWeight: FontWeight.w600),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.vertFonce,
        foregroundColor: AppColors.blanc,
        titleTextStyle: GoogleFonts.fredoka(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: AppColors.blanc,
        ),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.vertOlive;
          }
          return AppColors.blanc;
        }),
      ),
      tabBarTheme: TabBarThemeData(
        indicator: BoxDecoration(
            color: AppColors.vertFonce,
            borderRadius: BorderRadius.circular(30)),
        dividerColor: Colors.transparent,
        indicatorSize: TabBarIndicatorSize.tab,
        labelColor: Colors.white,
        unselectedLabelColor: Colors.grey,
        labelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      navigationBarTheme: const NavigationBarThemeData(
        backgroundColor: AppColors.blanc,
      ),
    );
  }
}
