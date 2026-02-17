import 'dart:async';

import 'package:dio/dio.dart';
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
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

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

  String _extractErrorMessage(Object error) {
    if (error is DioException) {
      final responseData = error.response?.data;
      if (responseData is Map && responseData['message'] != null) {
        return responseData['message'].toString();
      }
      return error.message ?? "Request failed";
    }

    final text = error.toString();
    if (text.startsWith("Exception: ")) {
      return text.substring("Exception: ".length);
    }
    return text;
  }

  // ==========================
  // Login
  // ==========================
  Future<void> login({required String email, required String password}) async {
    try {
      _setLoading(true);
      _setError(null);

      final user = await _repository.login(email: email, password: password);

      _currentUser = user;
    } catch (e) {
      _setError(_extractErrorMessage(e));
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
    required String phone,
    required String password,
  }) async {
    try {
      _setLoading(true);
      _setError(null);

      await _repository.register(
        name: name,
        email: email,
        phone: phone,
        password: password,
      );
    } catch (e) {
      _setError(_extractErrorMessage(e));
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
      _setError(_extractErrorMessage(e));
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
      _setError(_extractErrorMessage(e));
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
      _setError(_extractErrorMessage(e));
    } finally {
      _setLoading(false);
    }
  }

  // ==========================
  // Clear State
  // ==========================
  void clearState() {
    _errorMessage = null;
    // _currentUser = null;
    emailController.clear();
    passwordController.clear();
    notifyListeners();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
    
  }

  //  ==========================
  // Toggle Password Visibility (For Login/Register Forms)
  // ==========================
  bool isPasswordVisible = false;
  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    notifyListeners();
  }

  // ==========================
  // Additional State for Register Form (e.g., confirm password visibility, terms agreement)
  // ==========================
  bool isRegisterPasswordVisible = false;
  void toggleRegisterPassword() {
    isRegisterPasswordVisible = !isRegisterPasswordVisible;
    notifyListeners();
  }

  // ==========================
  // Additional State for Register Form (e.g., confirm password visibility, terms agreement)
  // ==========================
  bool isConfirmPasswordVisible = false;
  void toggleConfirmPassword() {
    isConfirmPasswordVisible = !isConfirmPasswordVisible;
    notifyListeners();
  }

  //  ==========================
  // Additional State for Register Form (e.g., confirm password visibility, terms agreement)
  // ==========================
  bool agreeTerms = false;
  void toggleAgreeTerms(bool value) {
    agreeTerms = value;
    notifyListeners();
  }

  // ================= OTP STATE =================

  final List<TextEditingController> otpControllers = List.generate(
    6,
    (_) => TextEditingController(),
  );

  final List<FocusNode> otpFocusNodes = List.generate(6, (_) => FocusNode());

  int secondsRemaining = 60;
  Timer? _timer;

  void startOtpTimer() {
    secondsRemaining = 60;
    notifyListeners();

    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsRemaining == 0) {
        timer.cancel();
      } else {
        secondsRemaining--;
        notifyListeners();
      }
    });
  }

  void onOtpChanged(int index, String value) {
    if (value.isNotEmpty && index < otpFocusNodes.length - 1) {
      otpFocusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      otpFocusNodes[index - 1].requestFocus();
    }

    if (value.isNotEmpty && index < 5) {
      otpFocusNodes[index + 1].requestFocus();
    }
    notifyListeners();
  }

  String get otp => otpControllers.map((c) => c.text).join();

  bool get isOtpComplete => otp.length == 6;
  
  void disposeOtp() {
    _timer?.cancel();
    for (var c in otpControllers) {
      c.dispose();
    }
    for (var f in otpFocusNodes) {
      f.dispose();
    }
  }
Future<bool> verifyOtp({
  required String email,
  required String otp,
}) async {
  try {
    _setError(null);
    final user = await _repository.verifyOtp(
      email: email,
      otp: otp,
    );

    _currentUser = user;
    notifyListeners();
    debugPrint("[UserController.verifyOtp] Success for $email");

    return true;
  } on DioException catch (e, st) {
    debugPrint(
      "[UserController.verifyOtp] DioException status=${e.response?.statusCode} data=${e.response?.data}",
    );
    debugPrint(st.toString());
    _setError(_extractErrorMessage(e));
    return false;
  } catch (e, st) {
    debugPrint("[UserController.verifyOtp] Error: $e");
    debugPrint(st.toString());
    _setError(_extractErrorMessage(e));
    return false;
  }
}

Future<bool> resendEmailOtp({
  required String email,
}) async {
  try {
    _setError(null);
    await _repository.resendEmailOtp(email: email);
    return true;
  } catch (e) {
    _setError(_extractErrorMessage(e));
    return false;
  }
}

  
  
}
