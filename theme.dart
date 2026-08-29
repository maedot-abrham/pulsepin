import 'package:flutter/material.dart';

class PulsePinTheme {
  static const Color primary = Color(0xFF7B2FFD);
  static const Color secondary = Color(0xFF00E0C6);
  static const Color background = Color(0xFF0F0F1A);
  static const Color surface = Color(0xFF1A1A2E);
  static const Color text = Color(0xFFF8F7FC);
  static const Color accent = Color(0xFFFF2D92);

  static ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: background,
    primaryColor: primary,
    colorScheme: const ColorScheme.dark(
      primary: primary,
      secondary: secondary,
      surface: surface,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: text, fontSize: 16),
      bodyMedium: TextStyle(color: text, fontSize: 14),
      titleLarge: TextStyle(color: text, fontSize: 22, fontWeight: FontWeight.bold),
    ),
  );
}

