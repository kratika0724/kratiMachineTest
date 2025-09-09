import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/usermodel.dart';
import '../services/apiservices.dart';

class UserProvider extends ChangeNotifier {
  List<User> _users = [];
  List<User> _filteredUsers = [];
  bool _isLoading = false;
  String _errorMessage = '';
  String _searchQuery = '';

  List<User> get users => _filteredUsers;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  String get searchQuery => _searchQuery;
  bool get hasUsers => _users.isNotEmpty;

  UserProvider() {
    _loadCachedUsers();
  }

  /// Load cached users from SharedPreferences
  Future<void> _loadCachedUsers() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('users');
    if (data != null) {
      List<dynamic> jsonList = jsonDecode(data);
      _users = jsonList.map((e) => User.fromJson(e)).toList();
      _filteredUsers = List.from(_users);
      notifyListeners();
    }
  }

  /// Save users to SharedPreferences
  Future<void> _cacheUsers(List<User> users) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonList = users.map((e) => e.toJson()).toList();
      await prefs.setString('users', jsonEncode(jsonList));
    } catch (e) {
      debugPrint('Error caching users: $e');
    }
  }

  /// Fetch users from API
  Future<void> fetchUsers({bool refresh = false}) async {
    if (_isLoading) return;

    _isLoading = true;
    _errorMessage = '';

    if (!refresh) {
      notifyListeners();
    }

    try {
      final fetchedUsers = await ApiService.getUsers();
      _users = fetchedUsers;
      _applySearchFilter();

      await _cacheUsers(fetchedUsers);

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _errorMessage = e.toString();

      if (_users.isEmpty) {
        notifyListeners();
      } else {
        _errorMessage = 'Using cached data - ${e.toString()}';
        notifyListeners();
      }
    }
  }

  /// Search users
  void searchUsers(String query) {
    _searchQuery = query;
    _applySearchFilter();
    notifyListeners();
  }

  void _applySearchFilter() {
    if (_searchQuery.isEmpty) {
      _filteredUsers = List.from(_users);
    } else {
      _filteredUsers = _users
          .where((user) =>
      user.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          user.email.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          user.username.toLowerCase().contains(_searchQuery.toLowerCase()))
          .toList();
    }
  }

  void clearSearch() {
    _searchQuery = '';
    _filteredUsers = List.from(_users);
    notifyListeners();
  }

  void clearError() {
    _errorMessage = '';
    notifyListeners();
  }

  User? getUserById(int id) {
    try {
      return _users.firstWhere((user) => user.id == id);
    } catch (_) {
      return null;
    }
  }

  Future<void> retry() async => fetchUsers();
  Future<void> refresh() async => fetchUsers(refresh: true);
}
