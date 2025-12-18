import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF0B0F1A),
    colorScheme: ColorScheme.dark(
      primary: const Color(0xFF4D9CFF), // electric blue
      secondary: const Color(0xFF9D6BFF), // neon purple
      tertiary: const Color(0xFF4DFFB8), // subtle neon green
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(fontWeight: FontWeight.bold),
      titleLarge: TextStyle(fontWeight: FontWeight.w600),
    ),
    cardTheme: CardThemeData(
      color: const Color(0xFF11162A),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
  );
}
