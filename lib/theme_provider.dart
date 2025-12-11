import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  ThemeMode get themeMode => _themeMode;

  String _fontFamily = 'Lato';
  String get fontFamily => _fontFamily;

  ThemeProvider() {
    _loadThemePreference();
    _loadFontPreference();
  }

  Future<void> _loadThemePreference() async {
    final prefs = await SharedPreferences.getInstance();
    final isDarkMode = prefs.getBool('isDarkMode');
    if (isDarkMode != null) {
      _themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
      notifyListeners();
    }
  }

  Future<void> _saveThemePreference(bool isDarkMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', isDarkMode);
  }

  void toggleTheme(bool isDarkMode) {
    _themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    _saveThemePreference(isDarkMode);
    notifyListeners();
  }

  Future<void> _loadFontPreference() async {
    final prefs = await SharedPreferences.getInstance();
    _fontFamily = prefs.getString('fontFamily') ?? 'Lato';
    notifyListeners();
  }

  Future<void> _saveFontPreference(String fontName) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('fontFamily', fontName);
  }

  void changeFont(String fontName) {
    if (_fontFamily == fontName) return;
    _fontFamily = fontName;
    _saveFontPreference(fontName);
    notifyListeners();
  }
}
