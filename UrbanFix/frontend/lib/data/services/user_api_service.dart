import 'package:dio/dio.dart';
import 'package:frontend/core/utils/token_store.dart';
import '../../core/constants/api_constants.dart';
import '../models/user_model.dart';
import 'dio_client.dart';

class UserApiService {
  final Dio _dio = DioClient().dio;

  // ==========================
  // Register
  // ==========================
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

  // ==========================
  // Login
  // ==========================
 Future<List<UserModel>> login(String email, String password) async {
  try {
    final response = await _dio.post(ApiConstants.login, data: {
      "email": email,
      "password": password
    });
    final data = response.data;
    // Check status code (optional, Dio may already throw on non-2xx)
    if (response.statusCode != 200) {
      throw Exception("Login failed");
    }
    // Extract and store token (assumes token is at top level)
    final String? token = data['token'];
    if (token != null) {
      TokenStore.setToken(token);
    }
    // Parse user data into a list of UserModel
    List<UserModel> users = [];

    if (data is Map<String, dynamic>) {
      // Case 1: Response contains a single user under 'user' key
      if (data.containsKey('user') && data['user'] is Map<String, dynamic>) {
        users = [UserModel.fromJson(data['user'] as Map<String, dynamic>)];
      }
      // Case 2: Response contains a list of users under 'users' key
      else if (data.containsKey('users') && data['users'] is List) {
        users = (data['users'] as List)
            .map((json) => UserModel.fromJson(json as Map<String, dynamic>))
            .toList();
      }
      // Case 3: The entire response map is the user object
      else {
        users = [UserModel.fromJson(data)];
      }
    } else if (data is List) {
      // Case 4: Response is directly a list of users
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
  // ==========================
  // Get Profile
  // ==========================
  Future<List<UserModel>> getProfile() async {
  try {
    final response = await _dio.get('${ApiConstants.userProfile}/profile');
    final data = response.data;
    List<UserModel> users = [];
    if (data is Map<String, dynamic>) {
      // Case 1: Response contains a single user under 'user' key
      if (data.containsKey('user') && data['user'] is Map<String, dynamic>) {
        users = [UserModel.fromJson(data['user'] as Map<String, dynamic>)];
      }
      // Case 2: Response contains a list of users under 'users' key (unlikely for profile, but included for consistency)
      else if (data.containsKey('users') && data['users'] is List) {
        users = (data['users'] as List)
            .map((json) => UserModel.fromJson(json as Map<String, dynamic>))
            .toList();
      }
      // Case 3: The entire response map is the user object
      else {
        users = [UserModel.fromJson(data)];
      }
    } else if (data is List) {
      // Case 4: Response is directly a list of users
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

  // ==========================
  // Update Profile
  // ==========================
  Future<List<UserModel>> updateProfile(String name, String phone) async {
  try {
    final response = await _dio.put(
      '${ApiConstants.updateProfile}/update',
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

  // ==========================
  // Logout
  // ==========================
  Future<List<UserModel>> logout() async {
  try {
    final response = await _dio.post(ApiConstants.logout, data: {  
    });
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

    // Clear the token only after successful response parsing
    // TokenStore.clearToken();
    return users;
  } on DioException catch (e) {
    throw Exception(e.response?.data["message"] ?? "Logout failed");
  }
}

  // ==========================
  // Verify OTP
  // ==========================
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

  // ==========================
  // Resend OTP
  // ==========================
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
