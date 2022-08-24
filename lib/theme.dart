import 'package:flutter/material.dart';

class CustomTheme {
  static const ColorScheme _lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFFFF8A00),
    onPrimary: Colors.white,
    secondary: Color(0xffff64d9),
    onSecondary: Color(0xFFFF8A00),
    error: Colors.red,
    onError: Colors.black,
    background: Colors.white,
    onBackground: Colors.black,
    surface: Colors.white,
    onSurface: Colors.black,
  );

  static final ThemeData _lightTheme = ThemeData(
    colorScheme: _lightColorScheme,
    textTheme: const TextTheme(
        headline1: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
        headline2: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w300),
        bodyText1: TextStyle(fontSize: 14.0),
        labelMedium: TextStyle(fontSize: 15.0),
        button: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold)),
  );

  static ThemeData get lightTheme => _lightTheme;
}
