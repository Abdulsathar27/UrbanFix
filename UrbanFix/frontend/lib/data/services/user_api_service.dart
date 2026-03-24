import 'package:dio/dio.dart';
import 'package:frontend/core/utils/token_store.dart';
import '../../core/constants/api_constants.dart';
import '../models/user_model.dart';
import 'dio_client.dart';

class UserApiService {
  final Dio _dio = DioClient().dio;
  Future<List<UserModel>>register(String email, String name, String phone, String password) async {
    try {
      final response = await _dio.post(
        '${ApiConstants.register}/create',
        data: {
          "email": email,
          "name": name,
          "phone": phone,
          "password": password
        }
      ); 
      if (response.statusCode != 200 &&
          response.statusCode != 201) {
        throw Exception("Registration failed");
      }
      final data = response.data;
      return data.map((json) => UserModel.fromJson(json as Map<String, dynamic>)).toList();
    } on DioException catch (e) {
      throw Exception(
        e.response?.data["message"] ?? "Registration failed",
      );
    }
  }

 
 Future<List<UserModel>> login(String email, String password) async {
  try {
    final response = await _dio.post(ApiConstants.login, data: {
      "email": email,
      "password": password
    });
    final data = response.data;
   
    if (response.statusCode != 200) {
      throw Exception("Login failed");
    }
  
    final String? token = data['token'];
    if (token != null) {
      TokenStore.setToken(token);
    }
   
    List<UserModel> users = [];

    if (data is Map<String, dynamic>) {
     
      if (data.containsKey('user') && data['user'] is Map<String, dynamic>) {
        users = [UserModel.fromJson(data['user'] as Map<String, dynamic>)];
      }
      
      else if (data.containsKey('users') && data['users'] is List) {
        users = (data['users'] as List)
            .map((json) => UserModel.fromJson(json as Map<String, dynamic>))
            .toList();
      }
      
      else {
        users = [UserModel.fromJson(data)];
      }
    } else if (data is List) {
      
      users = data
          .map((json) => UserModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception("Unexpected response format");
    }

    return users;
  } on DioException catch (e) {
    throw Exception(e.response?.data["message"] ?? "Login failed");
  }
}
  Future<List<UserModel>> getProfile() async {
  try {
    final response = await _dio.get(ApiConstants.userProfile);
    final data = response.data;
    List<UserModel> users = [];
    if (data is Map<String, dynamic>) {
            if (data.containsKey('user') && data['user'] is Map<String, dynamic>) {
        users = [UserModel.fromJson(data['user'] as Map<String, dynamic>)];
      }
    
      else if (data.containsKey('users') && data['users'] is List) {
        users = (data['users'] as List)
            .map((json) => UserModel.fromJson(json as Map<String, dynamic>))
            .toList();
      }
      
      else {
        users = [UserModel.fromJson(data)];
      }
    } else if (data is List) {
    
      users = data
          .map((json) => UserModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception("Unexpected response format");
    }
    return users;
  } on DioException catch (e) {
    throw Exception(e.response?.data["message"] ?? "Failed to fetch profile");
  }
}

  Future<List<UserModel>> updateProfile(String name, String phone) async {
  try {
    final response = await _dio.put(
      ApiConstants.updateProfile,
      data: {
        "name": name,
        "phone": phone
      }
    );

    final data = response.data;

    List<UserModel> users = [];

    if (data is Map<String, dynamic>) {
      if (data.containsKey('user') && data['user'] is Map<String, dynamic>) {
        users = [UserModel.fromJson(data['user'] as Map<String, dynamic>)];
      }
      else if (data.containsKey('users') && data['users'] is List) {
        users = (data['users'] as List)
            .map((json) => UserModel.fromJson(json as Map<String, dynamic>))
            .toList();
      }
      else {
        users = [UserModel.fromJson(data)];
      }
    } else if (data is List) {
      users = data
          .map((json) => UserModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception("Unexpected response format");
    }

    return users;
  } on DioException catch (e) {
    throw Exception(e.response?.data["message"] ?? "Profile update failed");
  }
}

  Future<void> logout() async {
    try {
      await _dio.post(ApiConstants.logout);
    } on DioException catch (e) {
      throw Exception(e.response?.data["message"] ?? "Logout failed");
    }
  }

  Future<Map<String, dynamic>> verifyOtp(String email, String otp) async {
  try {
    final response = await _dio.post(
      '${ApiConstants.verifyEmail}/verify',
      data: {
        "email": email,
        "otp": otp
      }
    );
    if (response.data == null) {
      throw Exception("Empty response from OTP verification");
    }

    return Map<String, dynamic>.from(response.data);
  } on DioException catch (e) {
    throw Exception(
      e.response?.data["message"] ??
          "OTP verification failed",
    );
  }
}

  Future<List<UserModel>> resendEmailOtp(String email) async {
    try {
      final response = await _dio.post(
        '${ApiConstants.resendEmailOtp}/resend',
        data: {
          "email": email
        }
      );
      final data = response.data;

      List<UserModel> users = [];

      if (data is Map<String, dynamic>) {
        if (data.containsKey('user') && data['user'] is Map<String, dynamic>) {
          users = [UserModel.fromJson(data['user'] as Map<String, dynamic>)];
        } else if (data.containsKey('users') && data['users'] is List) {
          users = (data['users'] as List)
              .map((json) => UserModel.fromJson(json as Map<String, dynamic>))
              .toList();
        } else {
          users = [UserModel.fromJson(data)];
        }
      } else if (data is List) {
        users = data
            .map((json) => UserModel.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception("Unexpected response format");
      }

      return users;
    } on DioException catch (e) {
      throw Exception(
        e.response?.data["message"] ??
            "Failed to resend OTP",
      );
    }
  }
}
