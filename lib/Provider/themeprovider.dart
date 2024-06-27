import 'package:flutter/material.dart';
import 'package:notes/themes/themes.dart';

class Themeprovider with ChangeNotifier {
  bool isSwitched = false;
  ThemeData _themeData = darkMode;
  ThemeData get themeData => _themeData;

  void setTheme(ThemeData newTheme) {
    _themeData = newTheme;
  }

  void toggleTheme() {
    isSwitched = !isSwitched;
    if (_themeData == darkMode) {
      setTheme(lightMode);
    } else {
      setTheme(darkMode);
    }
    notifyListeners();
  }
}
