import 'package:flutter/material.dart';
import '../services/storageservices.dart';

class ThemeProvider with ChangeNotifier {
  bool _isDarkMode = false;
  final StorageService _storageService = StorageService();

  bool get isDarkMode => _isDarkMode;

  ThemeProvider() {
    _loadThemeMode();
  }

  /// Load theme preference from storage
  Future<void> _loadThemeMode() async {
    _isDarkMode = await _storageService.loadThemeMode();
    notifyListeners();
  }

  /// Toggle theme mode
  Future<void> toggleTheme() async {
    _isDarkMode = !_isDarkMode;
    await _storageService.saveThemeMode(_isDarkMode);
    notifyListeners();
  }

  /// Set specific theme mode
  Future<void> setThemeMode(bool isDark) async {
    if (_isDarkMode != isDark) {
      _isDarkMode = isDark;
      await _storageService.saveThemeMode(_isDarkMode);
      notifyListeners();
    }
  }
}