import 'package:frontend/data/services/dio_client.dart';
import 'package:frontend/data/services/user_api_service.dart';
import '../models/user_model.dart';

class UserRepository {
  final UserApiService _apiService;

  UserRepository()
      : _apiService = UserApiService(DioClient());

  // ==========================
  // Login
  // ==========================
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    final response = await _apiService.login(
      email: email,
      password: password,
    );

    // Adjust according to backend response structure
    final String token = response['token'];
    final Map<String, dynamic> userJson = response['user'];

    // TODO: Store token using SharedPreferences later
    // Example:
    // await TokenStorage.saveToken(token);

    return UserModel.fromJson(userJson);
  }

  // ==========================
  // Register
  // ==========================
  Future<UserModel> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final response = await _apiService.register(
      name: name,
      email: email,
      password: password,
    );

    final String token = response['token'];
    final Map<String, dynamic> userJson = response['user'];

    // TODO: Store token

    return UserModel.fromJson(userJson);
  }

  // ==========================
  // Get Profile
  // ==========================
  Future<UserModel> getProfile() async {
    return await _apiService.getProfile();
  }

  // ==========================
  // Update Profile
  // ==========================
  Future<UserModel> updateProfile({
    required String name,
    required String phone,
  }) async {
    return await _apiService.updateProfile(
      name: name,
      phone: phone,
    );
  }

  // ==========================
  // Logout
  // ==========================
  Future<void> logout() async {
    await _apiService.logout();

    // TODO: Clear stored token
  }
}
