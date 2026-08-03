import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app_2026/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  // state variables
  String? _token;
  bool _isLoading = false;
  String _errorMessage = '';

  // public getters
  String? get token => _token;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  bool get isAuthenticated => _token != null;

  // check if user is already logged in
  Future<void> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('jwt_token');
    notifyListeners();
  }

  // ================== SEND OTP ========================
  Future<bool> sendOtp(String email) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/v1/send/email/otp'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'email': email}),
      );

      if (response.statusCode == 201) {
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _errorMessage = 'Failed to send OTP ${response.body}';
      }
    } catch (error) {
      _errorMessage = "Failed to send otp: $error";
    }

    _isLoading = false;
    notifyListeners();
    return false;
  }

  // ================== VERIFY OTP ========================
  Future<bool> verifyOtp(String email, String otp) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/v1/verify/email/otp'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'email': email, 'otp': otp}),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        _token = data['token'];

        // save token to shared preferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('jwt_token', _token!);

        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _errorMessage = 'Failed to send OTP ${response.body}';
      }
    } catch (error) {
      _errorMessage = "Failed to send otp: $error";
    }

    _isLoading = false;
    notifyListeners();
    return false;
  }

  // ============ LOGOUT USER ===============
  Future<void> logout() async {
    _token = null;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('jwt_token');
    notifyListeners();
  }
}
