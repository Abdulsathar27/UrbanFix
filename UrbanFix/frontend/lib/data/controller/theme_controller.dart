import 'package:flutter/material.dart';
import 'package:frontend/core/themes/dark_theme.dart';
import 'package:frontend/core/themes/light_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends ChangeNotifier {
  static const _key = 'theme_mode';

  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  ThemeData get lightTheme => LightTheme.theme;
  ThemeData get darkTheme => DarkTheme.theme;

  bool get isDarkMode => _themeMode == ThemeMode.dark;

  ThemeController() {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString(_key);
    if (saved == 'dark') {
      _themeMode = ThemeMode.dark;
    } else if (saved == 'light') {
      _themeMode = ThemeMode.light;
    } else {
      _themeMode = ThemeMode.system;
    }
    notifyListeners();
  }

  Future<void> _saveTheme(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    if (mode == ThemeMode.dark) {
      await prefs.setString(_key, 'dark');
    } else if (mode == ThemeMode.light) {
      await prefs.setString(_key, 'light');
    } else {
      await prefs.setString(_key, 'system');
    }
  }

  void setLightMode() {
    _themeMode = ThemeMode.light;
    _saveTheme(ThemeMode.light);
    notifyListeners();
  }

  void setDarkMode() {
    _themeMode = ThemeMode.dark;
    _saveTheme(ThemeMode.dark);
    notifyListeners();
  }

  void toggleTheme() {
    if (_themeMode == ThemeMode.dark) {
      _themeMode = ThemeMode.light;
      _saveTheme(ThemeMode.light);
    } else {
      _themeMode = ThemeMode.dark;
      _saveTheme(ThemeMode.dark);
    }
    notifyListeners();
  }

  void setSystemMode() {
    _themeMode = ThemeMode.system;
    _saveTheme(ThemeMode.system);
    notifyListeners();
  }
}
