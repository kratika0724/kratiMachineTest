import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/apiservices.dart';


class AuthProvider extends ChangeNotifier {
  bool _isAuthenticated = false;
  bool _isLoading = false;
  String _errorMessage = '';

  bool get isAuthenticated => _isAuthenticated;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  AuthProvider() {
    _loadAuthenticationState();
  }

  /// Load authentication state from SharedPreferences
  Future<void> _loadAuthenticationState() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _isAuthenticated = prefs.getBool('isAuthenticated') ?? false;
      notifyListeners();
    } catch (e) {
      debugPrint('Error loading authentication state: $e');
    }
  }

  /// Save authentication state to SharedPreferences
  Future<void> _saveAuthenticationState(bool isAuth) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isAuthenticated', isAuth);
    } catch (e) {
      debugPrint('Error saving authentication state: $e');
    }
  }

  /// Authenticate user with email and password
  Future<bool> login(String email, String password) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      final isAuthenticated = await ApiService.authenticate(email, password);

      if (isAuthenticated) {
        _isAuthenticated = true;
        await _saveAuthenticationState(true);
        _errorMessage = '';
      } else {
        _errorMessage = 'Invalid email or password. Please try again.';
      }

      _isLoading = false;
      notifyListeners();
      return isAuthenticated;
    } catch (e) {
      _isLoading = false;
      _errorMessage = 'Login failed: ${e.toString()}';
      notifyListeners();
      return false;
    }
  }

  /// Logout user
  Future<void> logout() async {
    _isAuthenticated = false;
    _errorMessage = '';
    await _saveAuthenticationState(false);
    notifyListeners();
  }

  /// Clear error message
  void clearError() {
    _errorMessage = '';
    notifyListeners();
  }

  /// Validate email format
  String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'Email is required';
    }

    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    if (!emailRegex.hasMatch(email)) {
      return 'Please enter a valid email address';
    }

    return null;
  }

  /// Validate password
  String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'Password is required';
    }

    if (password.length < 6) {
      return 'Password must be at least 6 characters long';
    }

    return null;
  }
}