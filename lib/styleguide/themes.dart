import 'package:flutter/material.dart';

// called in main.dart
ThemeData get customTheme {
  final baseTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Roboto',
    textTheme: _defaultTextTheme,
    primaryColor: Colors.teal,
    scaffoldBackgroundColor: Colors.white,
    colorScheme: const ColorScheme.light(
      primary: Colors.teal,
      secondary: Colors.lightBlueAccent,
    ),
  );

  return baseTheme.copyWith(
    elevatedButtonTheme: _customButtonTheme(baseTheme),
    textTheme: _defaultTextTheme,
  );
}

// text styles
TextTheme get _defaultTextTheme {
  return const TextTheme(
    headlineLarge: TextStyle(
      fontSize: 22,
    ),
    headlineMedium: TextStyle(
      fontSize: 20,
    ),
    headlineSmall: TextStyle(
      fontSize: 18,
    ),
    bodyLarge: TextStyle(
      fontSize: 16,
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
    ),
    bodySmall: TextStyle(
      fontSize: 13,
    ),
    labelLarge: TextStyle(
      fontSize: 11,
    ),
    labelMedium: TextStyle(
      fontSize: 10,
    ),
    labelSmall: TextStyle(
      fontSize: 8,
    ),
  );
}

// buttons style
ElevatedButtonThemeData _customButtonTheme(ThemeData baseTheme) {
  return ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.teal,
      padding: const EdgeInsets.symmetric(vertical: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      minimumSize: const Size(double.infinity, 40), // Set the width to expand across the container
      textStyle: baseTheme.textTheme.bodyMedium?.copyWith(
        fontWeight: FontWeight.w700,
        color: Colors.white,
      ),
    ),
  );
}
