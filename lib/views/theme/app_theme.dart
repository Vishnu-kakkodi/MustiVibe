import 'package:flutter/material.dart';

class AppColors {
  // Brand Colors (Exact Colors You Want)
  static const Color primary = Color(0xFFFE0A62);     // Dark Pink
  static const Color secondary = Color(0xFFFF7AA8);   // Light Pink

  // Light Mode Colors
  static const Color lightBackground = Color(0xFFF3F6FA);
  static const Color lightSurface = Colors.white;
  static const Color lightText = Colors.black87;

  // Dark Mode Colors
  static const Color darkBackground = Color(0xFF050B10);
  static const Color darkSurface = Color(0xFF111827);
  static const Color darkText = Colors.white;
}

class AppTheme {
  // 🌞 LIGHT THEME
  static ThemeData get lightTheme {
    const colorScheme = ColorScheme.light(
      primary: AppColors.primary,
      onPrimary: Colors.white,
      secondary: AppColors.secondary,
      onSecondary: Colors.white,
      background: AppColors.lightBackground,
      onBackground: AppColors.lightText,
      surface: AppColors.lightSurface,
      onSurface: AppColors.lightText,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,

      scaffoldBackgroundColor: AppColors.lightBackground,
      canvasColor: AppColors.lightBackground,
      cardColor: AppColors.lightSurface,

      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: AppColors.lightText,
        centerTitle: true,
      ),

      // ALL BUTTONS
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          textStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
          elevation: 0,
        ),
      ),

      // TEXT FIELD STYLING
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(
            color: AppColors.primary,
            width: 1.8,
          ),
        ),
        hintStyle: TextStyle(
          color: Colors.grey.shade500,
          fontSize: 14,
        ),
      ),

      snackBarTheme: SnackBarThemeData(
        backgroundColor: Colors.black87,
        contentTextStyle: const TextStyle(color: Colors.white),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  // 🌚 DARK THEME
  static ThemeData get darkTheme {
    const colorScheme = ColorScheme.dark(
      primary: AppColors.primary,       // SAME PINK
      onPrimary: Colors.white,
      secondary: AppColors.secondary,
      onSecondary: Colors.white,
      background: AppColors.darkBackground,
      onBackground: AppColors.darkText,
      surface: AppColors.darkSurface,
      onSurface: AppColors.darkText,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,

      scaffoldBackgroundColor: AppColors.darkBackground,
      canvasColor: AppColors.darkBackground,
      cardColor: AppColors.darkSurface,

      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: AppColors.darkText,
        centerTitle: true,
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          textStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
          elevation: 0,
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.darkSurface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade800),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade800),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(
            color: AppColors.primary,
            width: 1.8,
          ),
        ),
        hintStyle: TextStyle(
          color: Colors.grey.shade500,
          fontSize: 14,
        ),
      ),

      snackBarTheme: SnackBarThemeData(
        backgroundColor: Colors.grey.shade900,
        contentTextStyle: const TextStyle(color: Colors.white),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
