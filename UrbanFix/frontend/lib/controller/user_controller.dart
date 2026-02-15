import 'package:flutter/material.dart';

import '../../data/models/user_model.dart';
import '../../data/repositories/user_repository.dart';

class UserController extends ChangeNotifier {
  final UserRepository _repository = UserRepository();

  UserModel? _currentUser;
  bool _isLoading = false;
  String? _errorMessage;

  // ==========================
  // Getters
  // ==========================
  UserModel? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isLoggedIn => _currentUser != null;

  // ==========================
  // Private State Helpers
  // ==========================
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setError(String? message) {
    _errorMessage = message;
    notifyListeners();
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  // ==========================
  // Login
  // ==========================
  Future<void> login({
    required String email,
    required String password,
  }) async {
    try {
      _setLoading(true);
      _setError(null);

      final user = await _repository.login(
        email: email,
        password: password,
      );

      _currentUser = user;
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  // ==========================
  // Register
  // ==========================
  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      _setLoading(true);
      _setError(null);

      final user = await _repository.register(
        name: name,
        email: email,
        password: password,
      );

      _currentUser = user;
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  // ==========================
  // Fetch Profile
  // ==========================
  Future<void> fetchProfile() async {
    try {
      _setLoading(true);
      _setError(null);

      final user = await _repository.getProfile();
      _currentUser = user;
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  // ==========================
  // Update Profile
  // ==========================
  Future<void> updateProfile({
    required String name,
    required String phone,
  }) async {
    try {
      _setLoading(true);
      _setError(null);

      final updatedUser = await _repository.updateProfile(
        name: name,
        phone: phone,
      );

      _currentUser = updatedUser;
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  // ==========================
  // Logout
  // ==========================
  Future<void> logout() async {
    try {
      _setLoading(true);
      await _repository.logout();
      _currentUser = null;
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }
}
