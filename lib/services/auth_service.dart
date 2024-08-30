import 'package:flutter/material.dart';
import 'package:skillforge_ai/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService extends ChangeNotifier {
  User? _currentUser;
  bool _isDarkMode = false;
  bool _enableNotifications = true;
  final BuildContext context;

  User? get currentUser => _currentUser;
  bool get isAuthenticated => _currentUser != null;
  bool get isDarkMode => _isDarkMode;
  bool get enableNotifications => _enableNotifications;

  AuthService(this.context) {
    _loadUserData();
    _loadSettings();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');
    final userName = prefs.getString('userName');
    final userEmail = prefs.getString('userEmail');

    if (userId != null && userName != null && userEmail != null) {
      _currentUser = User(id: userId, name: userName, email: userEmail);
      notifyListeners();
    }
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool('isDarkMode') ?? false;
    _enableNotifications = prefs.getBool('enableNotifications') ?? true;
    notifyListeners();
  }

  Future<bool> login(String email, String password) async {
    try {
      bool success = await _authenticateUser(email, password);
      if (success) {
        _currentUser = User(id: '1', name: 'John Doe', email: email);
        await _saveUserData();
        notifyListeners();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login successful')),
        );
        return true;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login failed')),
      );
      return false;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login error: $e')),
      );
      return false;
    }
  }

  Future<bool> _authenticateUser(String email, String password) async {
    // This is a mock implementation. Replace with actual API call.
    await Future.delayed(
        const Duration(seconds: 2)); // Simulating network delay
    return email.contains('@') && password.length >= 6;
  }

  Future<void> _saveUserData() async {
    if (_currentUser != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('userId', _currentUser!.id);
      await prefs.setString('userName', _currentUser!.name);
      await prefs.setString('userEmail', _currentUser!.email);
    }
  }

  Future<void> logout() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('userId');
      await prefs.remove('userName');
      await prefs.remove('userEmail');
      _currentUser = null;
      notifyListeners();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Logout successful')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Logout error: $e')),
      );
    }
  }

  Future<void> setDarkMode(bool value) async {
    _isDarkMode = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', value);
    notifyListeners();
  }

  Future<void> setNotificationSettings(bool value) async {
    _enableNotifications = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('enableNotifications', value);
    notifyListeners();
  }
}
