import 'package:dio/dio.dart';
import '../../core/constants/api_constants.dart';
import '../models/user_model.dart';
import 'dio_client.dart';

class UserApiService {
  final Dio _dio;

  UserApiService(DioClient dioClient) : _dio = dioClient.dio;

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
      final response = await _dio.post(
        ApiConstants.register,
        data: {
          "name": name,
          "email": email,
          "phone": phone,
          "password": password,
        },
      );

      if (response.statusCode != 200 &&
          response.statusCode != 201) {
        throw Exception("Registration failed");
      }
    } on DioException catch (e) {
      throw Exception(
        e.response?.data["message"] ?? "Registration failed",
      );
    }
  }

  // ==========================
  // Login
  // ==========================
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dio.post(
        ApiConstants.login,
        data: {
          "email": email,
          "password": password,
        },
      );

      final data = response.data;

      if (data is Map && data['user'] is Map) {
        return UserModel.fromJson(
          Map<String, dynamic>.from(data['user']),
        );
      }

      return UserModel.fromJson(
        Map<String, dynamic>.from(data),
      );
    } on DioException catch (e) {
      throw Exception(
        e.response?.data["message"] ?? "Login failed",
      );
    }
  }

  // ==========================
  // Get Profile
  // ==========================
  Future<UserModel> getProfile() async {
    try {
      final response =
          await _dio.get(ApiConstants.userProfile);

      final data = response.data;

      if (data is Map && data['user'] is Map) {
        return UserModel.fromJson(
          Map<String, dynamic>.from(data['user']),
        );
      }

      return UserModel.fromJson(
        Map<String, dynamic>.from(data),
      );
    } on DioException catch (e) {
      throw Exception(
        e.response?.data["message"] ??
            "Failed to fetch profile",
      );
    }
  }

  // ==========================
  // Update Profile
  // ==========================
  Future<UserModel> updateProfile({
    required String name,
    required String phone,
  }) async {
    try {
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
          Map<String, dynamic>.from(data['user']),
        );
      }

      return UserModel.fromJson(
        Map<String, dynamic>.from(data),
      );
    } on DioException catch (e) {
      throw Exception(
        e.response?.data["message"] ??
            "Profile update failed",
      );
    }
  }

  // ==========================
  // Logout
  // ==========================
  Future<void> logout() async {
    try {
      await _dio.post(ApiConstants.logout);
    } on DioException catch (e) {
      throw Exception(
        e.response?.data["message"] ??
            "Logout failed",
      );
    }
  }

  // ==========================
  // Verify OTP
  // ==========================
  Future<void> verifyOtp({
    required String email,
    required String otp,
  }) async {
    try {
      final response = await _dio.post(
        ApiConstants.verifyEmail,
        data: {
          "email": email,
          "otp": otp,
        },
      );

      if (response.statusCode != 200) {
        throw Exception("OTP verification failed");
      }
    } on DioException catch (e) {
      throw Exception(
        e.response?.data["message"] ??
            "OTP verification failed",
      );
    }
  }

  // ==========================
  // Resend OTP
  // ==========================
  Future<void> resendEmailOtp({
    required String email,
  }) async {
    try {
      await _dio.post(
        ApiConstants.resendEmailOtp,
        data: {"email": email},
      );
    } on DioException catch (e) {
      throw Exception(
        e.response?.data["message"] ??
            "Failed to resend OTP",
      );
    }
  }
}
