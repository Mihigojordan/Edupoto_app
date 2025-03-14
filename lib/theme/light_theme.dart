import 'package:flutter/material.dart';
import 'package:hosomobile/util/color_resources.dart';
ThemeData light = ThemeData(
  brightness: Brightness.light,
  fontFamily: 'Rubik',
  primaryColor: const Color(0xFFFFEB3B),
  secondaryHeaderColor: const Color(0xFFfed114),
  highlightColor: const Color(0xFF000000),
  cardColor: Colors.white,
  shadowColor: Colors.grey[300],
  textTheme: const TextTheme(
    titleLarge: TextStyle(color:Color(0xFF1b4922)),
    titleSmall: TextStyle(color: Color(0xFF25282D)),
    // bodyLarge: TextStyle(color: Color(0xFF8dbac3)),
    // bodySmall: TextStyle(color: Color(0xFF25282D)),
    // bodyMedium: TextStyle(color: Color(0xFF8dbac3)),
    // titleMedium: TextStyle(color: Color(0xFF8dbac3)),
  ),
  dialogTheme: const DialogTheme(surfaceTintColor: Colors.white),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.white, selectedItemColor: ColorResources.themeLightBackgroundColor,
  ),
  colorScheme: ColorScheme(
    // background: const Color(0xFFf0f0f0),
    brightness: Brightness.light,
    primary: const Color(0xFFFFEB3B),
    onPrimary: const Color(0xFF562E9C),
    secondary: const Color(0xFFfed114),
    onSecondary: const Color(0xFFfed114),
    error: Colors.redAccent,
    onError: Colors.redAccent,
    surface: Colors.white,
    onSurface:  const Color(0xFF002349),
    shadow: Colors.grey[300],
  ),

);