import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart';

class AuthService {
  final String baseUrl = 'http://localhost:3000'; // Local development server
  final http.Client _client = http.Client();

  Future<User> login(String email, String password) async {
    try {
      final response = await _client.post(
        Uri.parse('$baseUrl/admin/login'),
        body: json.encode({'email': email, 'password': password}),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData['success']) {
          return User.fromJson(responseData['data']['admin']);
        } else {
          throw Exception(responseData['message']);
        }
      } else {
        throw Exception('Failed to login: ${response.statusCode}');
      }
    } catch (e) {
      print('Login error details: $e');
      throw Exception('Login error: $e');
    }
  }

  Future<void> logout() async {
    try {
      final response = await _client.post(
        Uri.parse('$baseUrl/admin/logout'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to logout');
      }
    } catch (e) {
      print('Logout error details: $e');
      throw Exception('Logout error: $e');
    }
  }

  Future<User> getCurrentUser() async {
    try {
      final response = await _client.get(
        Uri.parse('$baseUrl/admin/details'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData['success']) {
          return User.fromJson(responseData['data']);
        } else {
          throw Exception(responseData['message']);
        }
      } else {
        throw Exception('Failed to get current user: ${response.statusCode}');
      }
    } catch (e) {
      print('Get current user error details: $e');
      throw Exception('Get current user error: $e');
    }
  }
}
