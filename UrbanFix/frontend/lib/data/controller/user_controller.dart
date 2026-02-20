import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../../../data/models/user_model.dart';
import '../../../../data/services/user_api_service.dart';

class UserController extends ChangeNotifier {
  UserApiService userApiService = UserApiService();

  // ==========================
  // State
  // ==========================
  UserModel? _currentUser;
  bool _isLoading = false;
  String? _errorMessage;

  UserModel? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isLoggedIn => _currentUser != null;

  // ==========================
  // Form Controllers
  // ==========================
  final emailController = TextEditingController();
  final emailloginController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordLoginController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // ==========================
  // Private Helpers
  // ==========================
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setError(String? message) {
    _errorMessage = message;
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
  Future<bool> login({required String email, required String password}) async {
    try {
      _setLoading(true);
      _setError(null);

      final user = await userApiService.login(email: email, password: password);

      _currentUser = user;
      return true;
    } catch (e) {
      _setError(_extractErrorMessage(e));
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // ==========================
  // Register
  // ==========================
  Future<bool> register({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    try {
      _setLoading(true);
      _setError(null);

      await userApiService.register(
        name: name,
        email: email,
        phone: phone,
        password: password,
      );

      return true;
    } catch (e) {
      _setError(_extractErrorMessage(e));
      return false;
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

      final user = await userApiService.getProfile();
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
  Future<bool> updateProfile({
    required String name,
    required String phone,
  }) async {
    try {
      _setLoading(true);
      _setError(null);

      final updatedUser = await userApiService.updateProfile(
        name: name,
        phone: phone,
      );

      _currentUser = updatedUser;
      return true;
    } catch (e) {
      _setError(_extractErrorMessage(e));
      return false;
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
      await userApiService.logout();
      _currentUser = null;
    } catch (e) {
      _setError(_extractErrorMessage(e));
    } finally {
      _setLoading(false);
    }
  }

  // ==========================
  // OTP
  // ==========================
  final List<TextEditingController> otpControllers = List.generate(
    6,
    (_) => TextEditingController(),
  );

  final List<FocusNode> otpFocusNodes = List.generate(6, (_) => FocusNode());

  Timer? _timer;
  int secondsRemaining = 60;

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

  String get otp => otpControllers.map((c) => c.text).join();

  bool get isOtpComplete => otp.length == 6;

 Future<bool> verifyOtp({
  required String email,
  required String otp,
}) async {
  try {
    _setLoading(true);
    _setError(null);

    final response =
        await userApiService.verifyOtp(email: email, otp: otp);

    // Extract user from response
    final user = UserModel.fromJson(response['user']);

    _currentUser = user;

    return true;
  } catch (e) {
    _setError(_extractErrorMessage(e));
    return false;
  } finally {
    _setLoading(false);
  }
}

  Future<bool> resendEmailOtp({required String email}) async {
    try {
      _setError(null);
      await userApiService.resendEmailOtp(email: email);
      return true;
    } catch (e) {
      _setError(_extractErrorMessage(e));
      return false;
    }
  }

  // ==========================
  // UI State Toggles
  // ==========================
  bool isPasswordVisible = false;
  bool isRegisterPasswordVisible = false;
  bool isConfirmPasswordVisible = false;
  bool agreeTerms = false;

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    notifyListeners();
  }

  void toggleRegisterPassword() {
    isRegisterPasswordVisible = !isRegisterPasswordVisible;
    notifyListeners();
  }

  void toggleConfirmPassword() {
    isConfirmPasswordVisible = !isConfirmPasswordVisible;
    notifyListeners();
  }

  void toggleAgreeTerms(bool value) {
    agreeTerms = value;
    notifyListeners();
  }

  // ==========================
  // Dispose
  // ==========================
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    phoneController.dispose();
    confirmPasswordController.dispose();

    for (var c in otpControllers) {
      c.dispose();
    }
    for (var f in otpFocusNodes) {
      f.dispose();
    }

    _timer?.cancel();
    super.dispose();
  }

  void clearState() {
    _currentUser = null;
    _errorMessage = null;
    emailController.clear();
    emailloginController.clear();
    passwordLoginController.clear();
    passwordController.clear();
    nameController.clear();
    phoneController.clear();
    confirmPasswordController.clear();

    for (var c in otpControllers) {
      c.clear();
    }

    _timer?.cancel();
    secondsRemaining = 60;
    
  }
  void loginSuccess(UserModel user) {
  _currentUser = user;
  notifyListeners();
}



  // ==========================
  // Registration Form Validation
  //  =========================
  Future<bool> submitRegistration() async {
    // Clear previous error
    _setError(null);

    // Validate terms
    if (!agreeTerms) {
      _setError("Please accept terms");
      return false;
    }

    // Validate password match
    if (passwordController.text != confirmPasswordController.text) {
      _setError("Passwords do not match");
      return false;
    }

    // Validate empty fields
    if (nameController.text.trim().isEmpty ||
        emailController.text.trim().isEmpty ||
        phoneController.text.trim().isEmpty ||
        passwordController.text.trim().isEmpty) {
      _setError("All fields are required");
      return false;
    }

    try {
      _setLoading(true);

      await userApiService.register(
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        phone: phoneController.text.trim(),
        password: passwordController.text.trim(),
      );

      clearState();
      return true;
    } catch (e) {
      _setError(_extractErrorMessage(e));
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // ==========================
  // Login Form Validation
  // ==========================
  Future<bool> submitLogin() async {
    _setError(null);

    final email = emailloginController.text.trim();
    final password = passwordLoginController.text.trim();

    // Basic validation (business-level)
    if (email.isEmpty || password.isEmpty) {
      _setError("Email and password are required");
      return false;
    }

    try {
      _setLoading(true);

      final user = await userApiService.login(email: email, password: password);

      _currentUser = user;

      clearState();
      return true;
    } catch (e) {
      _setError(_extractErrorMessage(e));
      return false;
    } finally {
      _setLoading(false);
    }
  }
}
