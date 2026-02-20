import 'package:dio/dio.dart';

import '../../core/constants/api_constants.dart';
import '../models/notification_model.dart';
import 'dio_client.dart';

class NotificationApiService {
  final Dio _dio = DioClient().dio;

  

  // ==========================================================
  // Get All Notifications
  // ==========================================================
  Future<List<NotificationModel>> getNotifications() async {
    try {
      final response =
          await _dio.get(ApiConstants.notifications);

      final List<dynamic> data =
          response.data as List<dynamic>;

      return data
          .map((json) => NotificationModel.fromJson(
              json as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw Exception(
          "Failed to fetch notifications: ${e.message}");
    }
  }

  // ==========================================================
  // Mark Single Notification As Read
  // ==========================================================
  Future<void> markAsRead(
      String notificationId) async {
    try {
      await _dio.put(
        "${ApiConstants.notifications}/$notificationId/read",
      );
    } on DioException catch (e) {
      throw Exception(
          "Failed to mark notification as read: ${e.message}");
    }
  }

  // ==========================================================
  // Mark All Notifications As Read
  // ==========================================================
  Future<void> markAllAsRead() async {
    try {
      await _dio.put(
        "${ApiConstants.notifications}/read-all",
      );
    } on DioException catch (e) {
      throw Exception(
          "Failed to mark all notifications as read: ${e.message}");
    }
  }

  // ==========================================================
  // Delete Notification
  // ==========================================================
  Future<void> deleteNotification(
      String notificationId) async {
    try {
      await _dio.delete(
        "${ApiConstants.notifications}/$notificationId",
      );
    } on DioException catch (e) {
      throw Exception(
          "Failed to delete notification: ${e.message}");
    }
  }
}
