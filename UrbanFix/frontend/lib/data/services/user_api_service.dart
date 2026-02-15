import 'package:dio/dio.dart';

import '../../core/constants/api_constants.dart';
import '../models/user_model.dart';
import 'dio_client.dart';

class UserApiService {
  final Dio _dio;

  UserApiService(DioClient dioClient) : _dio = dioClient.dio;

  // ==========================
  // Login
  // ==========================
  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    final response = await _dio.post(
      ApiConstants.login,
      data: {
        "email": email,
        "password": password,
      },
    );

    return response.data;
  }

  // ==========================
  // Register
  // ==========================
  Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final response = await _dio.post(
      ApiConstants.register,
      data: {
        "name": name,
        "email": email,
        "password": password,
      },
    );

    return response.data;
  }

  // ==========================
  // Get Profile
  // ==========================
  Future<UserModel> getProfile() async {
    final response = await _dio.get(
      ApiConstants.userProfile,
    );

    return UserModel.fromJson(response.data);
  }

  // ==========================
  // Update Profile
  // ==========================
  Future<UserModel> updateProfile({
    required String name,
    required String phone,
  }) async {
    final response = await _dio.put(
      ApiConstants.updateProfile,
      data: {
        "name": name,
        "phone": phone,
      },
    );

    return UserModel.fromJson(response.data);
  }

  // ==========================
  // Logout
  // ==========================
  Future<void> logout() async {
    await _dio.post(ApiConstants.logout);
  }
}
