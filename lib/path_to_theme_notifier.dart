import 'package:flutter/material.dart';

class ThemeNotifier extends ChangeNotifier {
  late ThemeData _themeData;

  ThemeNotifier(this._themeData);

  get isDarkMode => null;

  ThemeData getTheme() => _themeData;

  void setTheme(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme() {
    _themeData =
        _themeData == ThemeData.dark() ? ThemeData.light() : ThemeData.dark();
    notifyListeners();
  }
}
