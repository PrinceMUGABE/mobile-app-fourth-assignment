import 'package:flutter/material.dart';

class ThemeNotifier extends ChangeNotifier {
  late ThemeData _themeData;
  bool _isDarkMode = false;

  ThemeNotifier(this._themeData);

  bool get isDarkMode => _isDarkMode;

  ThemeData getTheme() => _themeData;

  void setTheme(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    _themeData = _isDarkMode ? ThemeData.dark() : ThemeData.light();
    notifyListeners();
  }
}
