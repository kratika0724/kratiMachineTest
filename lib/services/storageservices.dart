import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/usermodel.dart';

class StorageService {
  static const String _usersKey = 'cached_users';
  static const String _themeKey = 'is_dark_mode';
  static const String _loginKey = 'is_logged_in';static final StorageService _instance = StorageService._internal();
  factory StorageService() => _instance;
  StorageService._internal();


  Future<bool> saveUsers(List<User> users) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final List<String> userJsonList = users
          .map((user) => json.encode(user.toJson()))
          .toList();
      return await prefs.setStringList(_usersKey, userJsonList);
    } catch (e) {
      print('Error saving users: $e');
      return false;
    }
  }


  Future<List<User>?> loadUsers() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final List<String>? userJsonList = prefs.getStringList(_usersKey);

      if (userJsonList != null) {
        return userJsonList
            .map((userJson) => User.fromJson(json.decode(userJson)))
            .toList();
      }
      return null;
    } catch (e) {
      print('Error loading users: $e');
      return null;
    }
  }


  Future<bool> clearUsers() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return await prefs.remove(_usersKey);
    } catch (e) {
      print('Error clearing users: $e');
      return false;
    }
  }

  Future<bool> saveThemeMode(bool isDarkMode) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return await prefs.setBool(_themeKey, isDarkMode);
    } catch (e) {
      print('Error saving theme: $e');
      return false;
    }
  }


  Future<bool> loadThemeMode() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getBool(_themeKey) ?? false;
    } catch (e) {
      print('Error loading theme: $e');
      return false;
    }
  }

  Future<bool> saveLoginStatus(bool isLoggedIn) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return await prefs.setBool(_loginKey, isLoggedIn);
    } catch (e) {
      print('Error saving login status: $e');
      return false;
    }
  }


  Future<bool> loadLoginStatus() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getBool(_loginKey) ?? false;
    } catch (e) {
      print('Error loading login status: $e');
      return false;
    }
  }

  Future<bool> clearAll() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return await prefs.clear();
    } catch (e) {
      print('Error clearing all data: $e');
      return false;
    }
  }
}