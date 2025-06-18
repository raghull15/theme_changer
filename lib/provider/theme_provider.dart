import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AppTheme { light, dark, system }

class ThemeProvider extends ChangeNotifier {
  AppTheme _theme = AppTheme.system;
  AppTheme get theme => _theme;

  ThemeMode get themeMode {
    switch (_theme) {
      case AppTheme.light:
        return ThemeMode.light;
      case AppTheme.dark:
        return ThemeMode.dark;
      case AppTheme.system:
      return ThemeMode.system;
    }
  }

  ThemeProvider() {
    _loadTheme();
  }

  void setTheme(AppTheme value) {
    _theme = value;
    _saveTheme(value);
    notifyListeners();
  }

  Future<void> _saveTheme(AppTheme value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('theme', value.index);
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final index = prefs.getInt('theme') ?? AppTheme.system.index;
    _theme = AppTheme.values[index];
    notifyListeners();
  }
}
