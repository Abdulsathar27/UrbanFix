import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:frontend/core/utils/token_store.dart';
import 'package:frontend/data/models/appointment_model.dart';
import 'package:frontend/data/models/service_model.dart';
import 'package:frontend/data/models/user_model.dart';
import 'package:frontend/data/services/user_api_service.dart';
import 'package:frontend/routes/app_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserController extends ChangeNotifier {
  UserApiService userApiService = UserApiService();

  
  UserModel? _currentUser;
  bool _isLoading = false;
  bool _editProfileReady = false;
  String? _errorMessage;

  UserModel? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  bool get editProfileReady => _editProfileReady;
  String? get errorMessage => _errorMessage;
  bool get isLoggedIn => _currentUser != null;

  
  void prepareEditProfile() {
    if (_currentUser == null) return;
    nameController.text = _currentUser!.name;
    phoneController.text = _currentUser!.phone ?? '';
    _editProfileReady = true;
   
  }

 
  final emailController = TextEditingController();
  final emailloginController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordLoginController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final TextEditingController searchController = TextEditingController();

  
  

  static const String _userKey = 'current_user';

  
  Future<void> initFromStorage() async {
    await TokenStore.loadToken();
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString(_userKey);
    if (userJson != null) {
      _currentUser = UserModel.fromJson(jsonDecode(userJson) as Map<String, dynamic>);
      notifyListeners();
    }
  }

  Future<void> _saveUserToStorage(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userKey, jsonEncode(user.toJson()));
  }

  Future<void> _clearUserFromStorage() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userKey);
  }

  

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

 
  Future<bool> login({required String email, required String password}) async {
    try {
      _setLoading(true);
      _setError(null);

      final user = await userApiService.login( email, password);

      _currentUser = user.first;
      await _saveUserToStorage(user.first);
      return true;
    } catch (e) {
      _setError(_extractErrorMessage(e));
      return false;
    } finally {
      _setLoading(false);
    }
  }

 
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


  Future<bool> updateProfile({
    required String name,
    required String phone,
  }) async {
    try {
      _setLoading(true);
      _setError(null);

      final updatedUser = await userApiService.updateProfile(name, phone);

      _currentUser = updatedUser.first;
      _editProfileReady = false; 
      return true;
    } catch (e) {
      _setError(_extractErrorMessage(e));
      return false;
    } finally {
      _setLoading(false);
    }
  }

  
  Future<void> logout() async {
    try {
      _setLoading(true);
      await userApiService.logout();
    } catch (e) {
      _setError(_extractErrorMessage(e));
      rethrow;
    } finally {
      _setLoading(false);
      clearState(clearCurrentUser: true);
      await TokenStore.clear();
      await _clearUserFromStorage();
    }
  }
  Future<void> handleLogout(BuildContext context, UserController controller) async {
  
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

 
  try {
    await controller.logout();
  } catch (_) {
   
  }
  AppRouter.router.go('/login');
}

 
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

      
      final user = UserModel.fromJson(response['user']);

      _currentUser = user;
      await _saveUserToStorage(user);

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

  
  @override
  void dispose() {
    emailController.dispose();
    emailloginController.dispose();
    passwordController.dispose();
    passwordLoginController.dispose();
    nameController.dispose();
    phoneController.dispose();
    confirmPasswordController.dispose();
    searchController.dispose(); 

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
    _editProfileReady = false;

    emailController.clear();
    emailloginController.clear();
    passwordLoginController.clear();
    passwordController.clear();
    nameController.clear();
    phoneController.clear();
    confirmPasswordController.clear();
    searchController.clear(); 

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

  
  Future<bool> submitRegistration() async {
    
    _setError(null);

   
    if (!agreeTerms) {
      _setError("Please accept terms");
      return false;
    }

   
    if (passwordController.text != confirmPasswordController.text) {
      _setError("Passwords do not match");
      return false;
    }

   
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

  
  Future<bool> submitLogin() async {
    _setError(null);

    final email = emailloginController.text.trim();
    final password = passwordLoginController.text.trim();


    if (email.isEmpty || password.isEmpty) {
      _setError("Email and password are required");
      return false;
    }

    try {
      _setLoading(true);

      final user = await userApiService.login(email, password);

      _currentUser = user.first;
      await _saveUserToStorage(user.first);

      clearState();
      return true;
    } catch (e) {
      _setError(_extractErrorMessage(e));
      return false;
    } finally {
      _setLoading(false);
    }
  }


  AppointmentModel? _currentAppointment;
  int _currentIndex = 0;
  bool _isChatFloating = false;

  AppointmentModel? get currentAppointment => _currentAppointment;
  int get currentIndex => _currentIndex;
  bool get isChatFloating => _isChatFloating;

 
  void changeTab(int index) {
    _currentIndex = index;
    _isChatFloating = false;
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
   
}
