import 'package:flutter/material.dart';

class AppTheme {
  // Light Theme Colors
  static const Color _lightPrimary = Color(0xFF2E7D32);
  static const Color _lightOnPrimary = Color(0xFFFFFFFF);
  static const Color _lightSecondary = Color(0xFF4CAF50);
  static const Color _lightOnSecondary = Color(0xFFFFFFFF);
  static const Color _lightSurface = Color(0xFFFFFBFE);
  static const Color _lightOnSurface = Color(0xFF1C1B1F);
  static const Color _lightBackground = Color(0xFFF1F8F4);

  // Dark Theme Colors
  static const Color _darkPrimary = Color(0xFF4CAF50);
  static const Color _darkOnPrimary = Color(0xFF000000);
  static const Color _darkSecondary = Color(0xFF66BB6A);
  static const Color _darkOnSecondary = Color(0xFF000000);
  static const Color _darkSurface = Color(0xFF1C1B1F);
  static const Color _darkOnSurface = Color(0xFFE6E1E5);
  static const Color _darkBackground = Color(0xFF121212);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'Poppins',
      colorScheme: const ColorScheme.light(
        primary: _lightPrimary,
        onPrimary: _lightOnPrimary,
        secondary: _lightSecondary,
        onSecondary: _lightOnSecondary,
        surface: _lightSurface,
        onSurface: _lightOnSurface,
        error: Color(0xFFBA1A1A),
        onError: Color(0xFFFFFFFF),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: _lightPrimary,
        foregroundColor: _lightOnPrimary,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: _lightOnPrimary,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: _lightPrimary,
          foregroundColor: _lightOnPrimary,
          elevation: 2,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      cardTheme: CardThemeData(
        color: _lightSurface,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
        fillColor: _lightSurface,
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'Poppins',
      colorScheme: const ColorScheme.dark(
        primary: _darkPrimary,
        onPrimary: _darkOnPrimary,
        secondary: _darkSecondary,
        onSecondary: _darkOnSecondary,
        surface: _darkSurface,
        onSurface: _darkOnSurface,
        error: Color(0xFFFFB4AB),
        onError: Color(0xFF690005),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: _darkPrimary,
        foregroundColor: _darkOnPrimary,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: _darkOnPrimary,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: _darkPrimary,
          foregroundColor: _darkOnPrimary,
          elevation: 2,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      cardTheme: CardThemeData(
        color: _darkSurface,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
        fillColor: _darkSurface,
      ),
    );
  }
} 