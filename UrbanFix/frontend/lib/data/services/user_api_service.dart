import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

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
    required String phone,
    required String password,
  }) async {
    final response = await _dio.post(
      ApiConstants.register,
      data: {
        "name": name,
        "email": email,
        "phone": phone,
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

    final data = response.data;
    if (data is Map && data['user'] is Map) {
      return UserModel.fromJson(
        Map<String, dynamic>.from(data['user'] as Map),
      );
    }

    return UserModel.fromJson(
      Map<String, dynamic>.from(data as Map),
    );
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

    final data = response.data;
    if (data is Map && data['user'] is Map) {
      return UserModel.fromJson(
        Map<String, dynamic>.from(data['user'] as Map),
      );
    }

    return UserModel.fromJson(
      Map<String, dynamic>.from(data as Map),
    );
  }

  // ==========================
  // Logout
  // ==========================
  Future<void> logout() async {
    await _dio.post(ApiConstants.logout);
  }
  // ==========================
  // Verify OTP 
 // ==========================  

  Future<Response<dynamic>> verifyOtp({
    required String email,
    required String otp,
  }) async {
    try {
      return await _dio.post(
        ApiConstants.verifyEmail,
        data: {
          "email": email,
          "otp": otp,
        },
      );
    } on DioException catch (e) {
      final fallbackPath = ApiConstants.verifyEmail == "/auth/verify-email"
          ? "/auth/verify-email-otp"
          : "/auth/verify-email";

      if (e.response?.statusCode == 404) {
        debugPrint(
          "[UserApiService.verifyOtp] ${ApiConstants.verifyEmail} not found. Retrying with $fallbackPath",
        );
        return await _dio.post(
          fallbackPath,
          data: {
            "email": email,
            "otp": otp,
          },
        );
      }

      rethrow;
    }
  }

  Future<void> resendEmailOtp({
    required String email,
  }) async {
    await _dio.post(
      ApiConstants.resendEmailOtp,
      data: {
        "email": email,
      },
    );
  }

}
