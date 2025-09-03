import 'package:flutter/material.dart';

ThemeData dark = ThemeData(
  fontFamily: 'Roboto',
  primaryColor: const Color(0xFF689da7),
  secondaryHeaderColor: const Color(0xFFaaa818),
  brightness: Brightness.dark,
  shadowColor: Colors.black.withOpacity(0.4),
  cardColor: const Color(0xFF29292D),
  textTheme: const TextTheme(
    titleLarge: TextStyle(color:Color(0xFF8dbac3)),
    titleSmall: TextStyle(color: Color(0xFF25282D)),
    // bodyLarge: TextStyle(color: Color(0xFF8dbac3)),
    // bodySmall: TextStyle(color: Color(0xFF25282D)),
    // bodyMedium: TextStyle(color: Color(0xFF8dbac3)),
    // titleMedium: TextStyle(color: Color(0xFF8dbac3)),
  ),
  // dialogTheme: const DialogTheme(surfaceTintColor: Colors.black),
  colorScheme: ColorScheme(
    brightness: Brightness.dark,
    primary: const Color(0xFF689da7),
    onPrimary: const Color(0xFF689da7),
    secondary: const Color(0xFFaaa818),
    onSecondary: const Color(0xFFaaa818),
    error: Colors.redAccent,
    onError: Colors.redAccent,
    surface: Colors.black,
    onSurface:  Colors.white70,
    shadow: Colors.black.withOpacity(0.4),
  ),
);
