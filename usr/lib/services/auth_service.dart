import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart';

class AuthService extends ChangeNotifier {
  User? _currentUser;
  bool get isAuthenticated => _currentUser != null;
  User? get currentUser => _currentUser;

  // Mocked auth - replace with Supabase calls
  Future<bool> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    if (email == 'test@example.com' && password == 'password') {
      _currentUser = User(id: '1', email: email, name: 'Test User');
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<bool> register(String email, String password, String name) async {
    await Future.delayed(const Duration(seconds: 1));
    _currentUser = User(id: DateTime.now().toString(), email: email, name: name);
    notifyListeners();
    return true;
  }

  Future<bool> resetPassword(String email) async {
    await Future.delayed(const Duration(seconds: 1));
    return true; // Simulate email sent
  }

  void logout() {
    _currentUser = null;
    notifyListeners();
  }
}