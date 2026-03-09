import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:frontend/core/utils/token_store.dart';
import 'package:frontend/data/models/appointment_model.dart';
import 'package:frontend/data/models/service_model.dart';
import 'package:frontend/data/models/user_model.dart';
import 'package:frontend/data/services/user_api_service.dart';
import 'package:go_router/go_router.dart';

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
  final TextEditingController searchController = TextEditingController();

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

      final user = await userApiService.login( email, password);

      _currentUser = user.first;
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

      await userApiService.register(name, email, phone, password);

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
      _currentUser = user.first;
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

      final updatedUser = await userApiService.updateProfile(name, phone);

      _currentUser = updatedUser.first;
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
      await userApiService.logout();          // your API call
      clearState(clearCurrentUser: true);     // your internal state clearing
    } catch (e) {
      final errorMsg = _extractErrorMessage(e);
      _setError(errorMsg);
      // Rethrow so the UI can react (show snackbar, etc.)
      rethrow;
    } finally {
      _setLoading(false);
      // Clear tokens regardless? This is a design choice.
      TokenStore.clear();
    }
  }
  Future<void> handleLogout(BuildContext context, UserController controller) async {
  // 1. Show confirmation dialog
  final shouldLogout = await showDialog<bool>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: const Text('Confirm Logout'),
      content: const Text('Are you sure you want to log out?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(ctx, false),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () => Navigator.pop(ctx, true),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
          ),
          child: const Text('Logout'),
        ),
      ],
    ),
  );

  if (shouldLogout != true) return;

  // 2. Perform logout via controller
  try {
    await controller.logout();
    // 3. If success, navigate to login
    if (context.mounted) {
      context.goNamed('/login');
    }
  } catch (e) {
    // 4. On error, show snackbar (error already set in controller)
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Logout failed: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
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

  Future<bool> verifyOtp({required String email, required String otp}) async {
    try {
      _setLoading(true);
      _setError(null);

      final response = await userApiService.verifyOtp(email, otp);

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
      await userApiService.resendEmailOtp(email);
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
    emailloginController.dispose();
    passwordController.dispose();
    passwordLoginController.dispose();
    nameController.dispose();
    phoneController.dispose();
    confirmPasswordController.dispose();
    searchController.dispose(); // ✅ FIXED: Now properly disposed

    for (var c in otpControllers) {
      c.dispose();
    }
    for (var f in otpFocusNodes) {
      f.dispose();
    }

    _timer?.cancel();
    super.dispose();
  }

  void clearState({bool clearCurrentUser = false}) {
    if (clearCurrentUser) {
      _currentUser = null;
    }

    _errorMessage = null;

    emailController.clear();
    emailloginController.clear();
    passwordLoginController.clear();
    passwordController.clear();
    nameController.clear();
    phoneController.clear();
    confirmPasswordController.clear();
    searchController.clear(); // ✅ ADDED: Clear search controller

    isPasswordVisible = false;
    isRegisterPasswordVisible = false;
    isConfirmPasswordVisible = false;
    agreeTerms = false;

    for (var c in otpControllers) {
      c.clear();
    }

    _timer?.cancel();
    secondsRemaining = 60;

    notifyListeners();
  }

  // ==========================
  // Registration Form Validation
  // =========================
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
        nameController.text.trim(),
        emailController.text.trim(),
        phoneController.text.trim(),
        passwordController.text.trim(),
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

    // Basic validation
    if (email.isEmpty || password.isEmpty) {
      _setError("Email and password are required");
      return false;
    }

    try {
      _setLoading(true);

      final user = await userApiService.login(email, password);

      _currentUser = user.first;

      clearState();
      return true;
    } catch (e) {
      _setError(_extractErrorMessage(e));
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // =============================
  // APPOINTMENT & NAVIGATION
  // =============================
  AppointmentModel? _currentAppointment;
  int _currentIndex = 0;
  bool _isChatFloating = false;

  AppointmentModel? get currentAppointment => _currentAppointment;
  int get currentIndex => _currentIndex;
  bool get isChatFloating => _isChatFloating;

 
  void changeTab(int index) {
    _currentIndex = index;
    _isChatFloating = false; // Close floating chat when changing tabs
    notifyListeners();
  }

  void openFloatingChat() {
    _isChatFloating = true;
    notifyListeners();
  }

  void closeFloatingChat() {
    _isChatFloating = false;
    notifyListeners();
  }

  // =============================
  // SERVICES
  // =============================
  // final List<String> _services = [
  //   'Plumbing',
  //   'Electrical',
  //   'Cleaning',
  //   'Painting',
  //   'Carpentry',
  //   'Moving',
  // ];

  // List<String> get services => _services;

  // String? _selectedService;
  // String? get selectedService => _selectedService;

  // void selectService(String serviceName) {
  //   _selectedService = serviceName;
  //   notifyListeners();
  // }

  // Add method to search services
  // List<String> getFilteredServices(String query) {
  //   if (query.isEmpty) return _services;
  //   return _services
  //       .where((service) => service.toLowerCase().contains(query.toLowerCase()))
  //       .toList();
  // }

  void clearSearch() {
    searchController.clear();
    notifyListeners();
  }
  
   final List<Service> services = [
    Service(
      name: 'Plumbing',
      icon: Icons.plumbing,
      color: Colors.blue,
      price: 50.0,
      description: 'Fix leaks, install pipes, unclog drains, and more.',
    ),
    Service(
      name: 'Electrical',
      icon: Icons.electrical_services,
      color: Colors.amber,
      price: 60.0,
      description: 'Wiring, fixture installation, troubleshooting electrical issues.',
    ),
    Service(
      name: 'Cleaning',
      icon: Icons.cleaning_services,
      color: Colors.green,
      price: 40.0,
      description: 'Deep cleaning, dusting, vacuuming, and sanitization.',
    ),
    Service(
      name: 'Painting',
      icon: Icons.brush,
      color: Colors.purple,
      price: 80.0,
      description: 'Interior and exterior painting, color consultation.',
    ),
    Service(
      name: 'Carpentry',
      icon: Icons.handyman,
      color: Colors.orange,
      price: 70.0,
      description: 'Custom furniture, repairs, shelving installation.',
    ),
    Service(
      name: 'Moving',
      icon: Icons.local_shipping,
      color: Colors.red,
      price: 100.0,
      description: 'Packing, loading, transportation, and unloading.',
    ),
  ];

  // You can remove the old services list if it was just strings
  // final List<String> services = [...]; // delete or comment out

  // Optional: a method to select a service (if needed)
  void selectService(Service service) {
    // maybe store selected service, or just use navigation directly
  }

   
}
