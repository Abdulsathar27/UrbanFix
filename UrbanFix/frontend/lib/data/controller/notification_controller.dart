import 'package:flutter/material.dart';
import 'package:frontend/data/models/notification_model.dart';
import 'package:frontend/data/services/notification_api_service.dart';

class NotificationController extends ChangeNotifier {
  NotificationApiService notificationApiService = NotificationApiService();

  List<NotificationModel> _notifications = [];
  bool _isLoading = false;
  String? _errorMessage;
  bool _hasFetched = false;
  List<NotificationModel> get notifications => _notifications;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get hasFetched => _hasFetched;

  int get unreadCount => _notifications.where((n) => !n.isRead).length;


  void _setLoading(bool value) {
    _isLoading = value;

    notifyListeners();
  }

  void _setError(String? message) {
    _errorMessage = message;
    notifyListeners();
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  Future<void> fetchNotifications() async {
    if (_isLoading) return;
    try {
      _setLoading(true);
      _setError(null);
      final data = await notificationApiService.getNotifications();
      data.sort(
        (a, b) => (b.createdAt ?? DateTime.now()).compareTo(
          a.createdAt ?? DateTime.now(),
        ),
      );
      _notifications = data;
      _hasFetched = true;
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }


  Future<void> markAsRead(String notificationId) async {
    // Optimistic update — mark as read locally immediately
    final index = _notifications.indexWhere((n) => n.id == notificationId);
    if (index != -1) {
      _notifications[index] = _notifications[index].copyWith(isRead: true);
      notifyListeners();
    }
    try {
      await notificationApiService.markAsRead(notificationId);
    } catch (_) {
      // Silently ignore API failure — local update already applied
    }
  }


  Future<void> markAllAsRead() async {
    // Optimistic update — mark all as read locally immediately
    _notifications = _notifications
        .map((n) => n.copyWith(isRead: true))
        .toList();
    notifyListeners();
    try {
      await notificationApiService.markAllAsRead();
    } catch (_) {
      // Silently ignore API failure — local update already applied
    }
  }


  Future<void> deleteNotification(String notificationId) async {
    try {
      await notificationApiService.deleteNotification(notificationId);

      _notifications.removeWhere((n) => n.id == notificationId);

      notifyListeners();
    } catch (e) {
      _setError(e.toString());
    }
  }


  void clearNotifications() {
    _notifications = [];
    _hasFetched = false;
    notifyListeners();
  }
}
