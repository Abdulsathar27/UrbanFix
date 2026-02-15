import 'package:dio/dio.dart';

import '../../core/constants/api_constants.dart';
import '../models/notification_model.dart';
import 'dio_client.dart';

class NotificationApiService {
  final Dio _dio;

  NotificationApiService(DioClient dioClient)
      : _dio = dioClient.dio;

  // ==========================
  // Get All Notifications
  // ==========================
  Future<List<NotificationModel>> getNotifications() async {
    final response = await _dio.get(
      ApiConstants.notifications,
    );

    final List data = response.data;

    return data
        .map((json) => NotificationModel.fromJson(json))
        .toList();
  }

  // ==========================
  // Mark Single Notification As Read
  // ==========================
  Future<void> markAsRead(String notificationId) async {
    await _dio.put(
      "${ApiConstants.notifications}/$notificationId/read",
    );
  }

  // ==========================
  // Mark All Notifications As Read
  // ==========================
  Future<void> markAllAsRead() async {
    await _dio.put(
      "${ApiConstants.notifications}/read-all",
    );
  }

  // ==========================
  // Delete Notification
  // ==========================
  Future<void> deleteNotification(
      String notificationId) async {
    await _dio.delete(
      "${ApiConstants.notifications}/$notificationId",
    );
  }
}
