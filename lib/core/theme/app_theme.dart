import 'package:flutter/material.dart';

class AppTheme {
  
  static const Color primaryBackground = Color(0xFF222831);
  static const Color secondaryBackground = Color(0xFF303338);
  static const Color placeholderText = Color(0xFF7C7E80);
  static const Color primaryText = Color(0xFFFFFFFF);
  static const Color accentBlue = Color(0xFF007AFF);

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: primaryBackground,
      scaffoldBackgroundColor: primaryBackground,
      colorScheme: const ColorScheme.dark(
        primary: accentBlue,
        secondary: secondaryBackground,
        surface: secondaryBackground,
        onPrimary: primaryText,
        onSecondary: primaryText,
        onSurface: primaryText,
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          color: primaryText,
          fontSize: 32,
          fontWeight: FontWeight.bold,
        ),
        headlineMedium: TextStyle(
          color: primaryText,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
        bodyLarge: TextStyle(
          color: primaryText,
          fontSize: 16,
        ),
        bodyMedium: TextStyle(
          color: placeholderText,
          fontSize: 14,
        ),
      ),
    );
  }
}
