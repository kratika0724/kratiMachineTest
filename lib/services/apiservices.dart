import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../models/usermodel.dart';


class ApiService {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';
  static const Duration timeoutDuration = Duration(seconds: 10);


  static Future<List<User>> getUsers() async {
    try {
      final response = await http
          .get(
        Uri.parse('$baseUrl/users'),
        headers: {'Content-Type': 'application/json'},
      )
          .timeout(timeoutDuration);

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((json) => User.fromJson(json)).toList();
      } else {
        throw ApiException(
          'Failed to load users. Status code: ${response.statusCode}',
          response.statusCode,
        );
      }
    } on SocketException {
      throw ApiException(
        'No internet connection. Please check your network settings.',
        0,
      );
    } on http.ClientException {
      throw ApiException(
        'Network error occurred. Please try again.',
        0,
      );
    } on FormatException {
      throw ApiException(
        'Invalid data format received from server.',
        0,
      );
    } catch (e) {
      if (e is ApiException) {
        rethrow;
      }
      throw ApiException(
        'An unexpected error occurred: ${e.toString()}',
        0,
      );
    }
  }


  static Future<User> getUserById(int id) async {
    try {
      final response = await http
          .get(
        Uri.parse('$baseUrl/users/$id'),
        headers: {'Content-Type': 'application/json'},
      )
          .timeout(timeoutDuration);

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        return User.fromJson(jsonData);
      } else if (response.statusCode == 404) {
        throw ApiException('User not found', 404);
      } else {
        throw ApiException(
          'Failed to load user. Status code: ${response.statusCode}',
          response.statusCode,
        );
      }
    } on SocketException {
      throw ApiException(
        'No internet connection. Please check your network settings.',
        0,
      );
    } on http.ClientException {
      throw ApiException(
        'Network error occurred. Please try again.',
        0,
      );
    } on FormatException {
      throw ApiException(
        'Invalid data format received from server.',
        0,
      );
    } catch (e) {
      if (e is ApiException) {
        rethrow;
      }
      throw ApiException(
        'An unexpected error occurred: ${e.toString()}',
        0,
      );
    }
  }


  static Future<bool> authenticate(String email, String password) async {

    await Future.delayed(const Duration(seconds: 1));


    if (email.isNotEmpty && password.isNotEmpty && password.length >= 6) {
      return true;
    }
    return false;
  }
}

class ApiException implements Exception {
  final String message;
  final int statusCode;

  ApiException(this.message, this.statusCode);

  @override
  String toString() => message;
}