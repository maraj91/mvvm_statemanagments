import 'package:flutter/material.dart';
import 'package:mvvm_statemanagments/constants/my_theme_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {

  ThemeData _themeMode = MyThemeData.getLightTheme();
  ThemeData get themeMode => _themeMode;
  final String themeKey = "isDarkMode";

  Future<void> loadTheme() async {
    final pref = await SharedPreferences.getInstance();
    final isDarkMode = pref.getBool(themeKey) ?? false;
    _themeMode = isDarkMode ? MyThemeData.getDarkTheme() : MyThemeData.getLightTheme();
    notifyListeners();
  }

  Future<void> toggleTheme() async {
    final pref = await SharedPreferences.getInstance();
    _themeMode = _themeMode == MyThemeData.getDarkTheme() ? MyThemeData.getLightTheme() : MyThemeData.getDarkTheme();
    await pref.setBool(themeKey, _themeMode == MyThemeData.getDarkTheme());
    notifyListeners();
  }
}