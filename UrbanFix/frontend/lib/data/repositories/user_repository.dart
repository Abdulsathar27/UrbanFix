import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:frontend/data/services/dio_client.dart';
import 'package:frontend/data/services/user_api_service.dart';
import 'package:frontend/core/utils/token_store.dart';
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
    final String? token = response['token']?.toString();
    final Map<String, dynamic> userJson = response['user'];

    if (token != null && token.isNotEmpty) {
      TokenStore.setToken(token);
    }

    return UserModel.fromJson(userJson);
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
    await _apiService.register(
      name: name,
      email: email,
      phone: phone,
      password: password,
    );
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
    TokenStore.clear();
    try {
      await _apiService.logout();
    } catch (_) {}
  }

  // ==========================
// Verify OTP
// ==========================
Future<UserModel> verifyOtp({
  required String email,
  required String otp,
}) async {
  try {
    final response = await _apiService.verifyOtp(
      email: email,
      otp: otp,
    );

    debugPrint(
      "[UserRepository.verifyOtp] status=${response.statusCode} data=${response.data}",
    );

    if (response.statusCode != 200) {
      throw Exception(
        "OTP verification failed with status ${response.statusCode}",
      );
    }

    final data = response.data;
    if (data is! Map) {
      throw Exception("Invalid OTP response format");
    }

    final map = Map<String, dynamic>.from(data);
    final String? token = map['token']?.toString();
    final userRaw = map['user'];

    if (token == null || token.isEmpty) {
      throw Exception(
        map['message']?.toString() ?? "Token missing in OTP response",
      );
    }

    if (userRaw is! Map) {
      throw Exception(
        map['message']?.toString() ?? "User missing in OTP response",
      );
    }

    TokenStore.setToken(token);
    final userJson = Map<String, dynamic>.from(userRaw);
    return UserModel.fromJson(userJson);
  } on DioException catch (e, st) {
    debugPrint(
      "[UserRepository.verifyOtp] DioException status=${e.response?.statusCode} data=${e.response?.data}",
    );
    debugPrint(st.toString());
    rethrow;
  } catch (e, st) {
    debugPrint("[UserRepository.verifyOtp] Error: $e");
    debugPrint(st.toString());
    rethrow;
  }
}

Future<void> resendEmailOtp({
  required String email,
}) async {
  await _apiService.resendEmailOtp(email: email);
}

}
