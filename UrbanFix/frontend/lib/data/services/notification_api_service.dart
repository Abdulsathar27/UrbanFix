import 'dart:developer';

import 'package:dio/dio.dart';
import '../../core/constants/api_constants.dart';
import '../models/notification_model.dart';
import 'dio_client.dart';

class NotificationApiService {
  final Dio _dio = DioClient().dio;

  Future<List<NotificationModel>> getNotifications() async {
    try {
      final response = await _dio.get(ApiConstants.notifications);
      final List<dynamic> data = response.data as List<dynamic>;
      log('$response what is the issue ');

      return data
          .map(
            (json) => NotificationModel.fromJson(json as Map<String, dynamic>),
          )
          .toList();
    } on DioException catch (e) {
      throw Exception("Failed to fetch notifications: ${e.message}");
    }
  }

  Future<NotificationModel> markAsRead(String notificationId) async {
    try {
      final response = await _dio.post(
        "${ApiConstants.notifications}/$notificationId/read",
        data: {"isRead": true},
      );
      return NotificationModel.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      print("Option 1 failed: ${e.message}");
      return await _markAsReadOption2(notificationId);
    }
  }

  Future<NotificationModel> _markAsReadOption2(String notificationId) async {
    try {
      final response = await _dio.put(
        "${ApiConstants.notifications}/$notificationId",
        data: {"isRead": true},
      );
      return NotificationModel.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      print("Option 2 failed: ${e.message}");
      // If Option 2 fails, try Option 3
      return await _markAsReadOption3(notificationId);
    }
  }

  Future<NotificationModel> _markAsReadOption3(String notificationId) async {
    try {
      final response = await _dio.post(
        "${ApiConstants.notifications}/$notificationId",
        data: {"isRead": true},
      );
      return NotificationModel.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      print("Option 3 failed: ${e.message}");
      return await _markAsReadOption4(notificationId);
    }
  }

  Future<NotificationModel> _markAsReadOption4(String notificationId) async {
    throw Exception(
      "Failed to mark notification as read. Please try again later.",
    );
  }

  Future<List<NotificationModel>> markAllAsRead() async {
    try {
      final response = await _dio.post(
        "${ApiConstants.notifications}/read-all",
        data: {"isRead": true},
      );
      final List<dynamic> data = response.data as List<dynamic>;
      return data
          .map(
            (json) => NotificationModel.fromJson(json as Map<String, dynamic>),
          )
          .toList();
    } on DioException catch (e) {
      throw Exception("Failed to mark all notifications as read: ${e.message}");
    }
  }

  Future<List<NotificationModel>> deleteNotification(
    String notificationId,
  ) async {
    try {
      final response = await _dio.delete(
        "${ApiConstants.notifications}/$notificationId",
      );
      final List<dynamic> data = response.data as List<dynamic>;
      return data
          .map(
            (json) => NotificationModel.fromJson(json as Map<String, dynamic>),
          )
          .toList();
    } on DioException catch (e) {
      throw Exception("Failed to delete notification: ${e.message}");
    }
  }
}
