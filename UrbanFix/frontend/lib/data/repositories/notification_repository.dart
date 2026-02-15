import 'package:frontend/data/services/dio_client.dart';
import 'package:frontend/data/services/notification_api_service.dart';
import '../models/notification_model.dart';

class NotificationRepository {
  final NotificationApiService _apiService;

  NotificationRepository()
      : _apiService = NotificationApiService(DioClient());

  // ==========================
  // Get All Notifications
  // ==========================
  Future<List<NotificationModel>> getNotifications() async {
    return await _apiService.getNotifications();
  }

  // ==========================
  // Mark Single As Read
  // ==========================
  Future<void> markAsRead(String notificationId) async {
    await _apiService.markAsRead(notificationId);
  }

  // ==========================
  // Mark All As Read
  // ==========================
  Future<void> markAllAsRead() async {
    await _apiService.markAllAsRead();
  }

  // ==========================
  // Delete Notification
  // ==========================
  Future<void> deleteNotification(
      String notificationId) async {
    await _apiService.deleteNotification(notificationId);
  }
}
