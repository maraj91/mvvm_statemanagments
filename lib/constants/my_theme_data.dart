import 'package:flutter/material.dart';

class MyThemeData {
  static ThemeData getLightTheme() {
    return ThemeData.light().copyWith(
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      colorScheme: ColorScheme.light(
        primary: Colors.white,
        onPrimary: Colors.black,
        secondary: Colors.black,
        onSecondary: Colors.white,
        tertiary: Colors.black,
        onTertiary: Colors.white,
        error: Colors.red,
        onError: Colors.white,
        surface: Colors.blue,
        onSurface: Colors.black,
      ),
      cardTheme: CardThemeData(
        color: Colors.white70,
        elevation: 5,
        margin: EdgeInsets.all(8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
    );
  }

  static ThemeData getDarkTheme() {
    return ThemeData.dark().copyWith(
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 1,
      ),
      colorScheme: ColorScheme.dark(
        primary: Colors.black,
        onPrimary: Colors.white,
        secondary: Colors.white,
        onSecondary: Colors.black,
        tertiary: Colors.white,
        onTertiary: Colors.black,
        error: Colors.red,
        onError: Colors.black,
        surface: Colors.blueGrey,
        onSurface: Colors.white,
      ),
      cardTheme: CardThemeData(
        color: Colors.black54,
        elevation: 5,
        margin: EdgeInsets.all(8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
    );
  }
}