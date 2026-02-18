import 'package:flutter/material.dart';

import '../../../../data/models/notification_model.dart';
import '../../../../data/services/notification_api_service.dart';

class NotificationController extends ChangeNotifier {
  final NotificationApiService _apiService;

  NotificationController(this._apiService);

  List<NotificationModel> _notifications = [];
  bool _isLoading = false;
  String? _errorMessage;

  // ==========================
  // Getters
  // ==========================
  List<NotificationModel> get notifications =>
      _notifications;

  bool get isLoading => _isLoading;

  String? get errorMessage => _errorMessage;

  int get unreadCount =>
      _notifications.where((n) => !n.isRead).length;

  // ==========================
  // Private Helpers
  // ==========================
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

  // ==========================
  // Fetch Notifications
  // ==========================
  Future<void> fetchNotifications() async {
    try {
      _setLoading(true);
      _setError(null);

      final data =
          await _apiService.getNotifications();

      // Sort newest first
      data.sort((a, b) =>
          (b.createdAt ?? DateTime.now())
              .compareTo(a.createdAt ?? DateTime.now()));

      _notifications = data;
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  // ==========================
  // Mark Single As Read
  // ==========================
  Future<void> markAsRead(
      String notificationId) async {
    try {
      await _apiService.markAsRead(notificationId);

      final index = _notifications.indexWhere(
          (n) => n.id == notificationId);

      if (index != -1) {
        _notifications[index] =
            _notifications[index]
                .copyWith(isRead: true);

        notifyListeners();
      }
    } catch (e) {
      _setError(e.toString());
    }
  }

  // ==========================
  // Mark All As Read
  // ==========================
  Future<void> markAllAsRead() async {
    try {
      await _apiService.markAllAsRead();

      _notifications = _notifications
          .map((n) => n.copyWith(isRead: true))
          .toList();

      notifyListeners();
    } catch (e) {
      _setError(e.toString());
    }
  }

  // ==========================
  // Delete Notification
  // ==========================
  Future<void> deleteNotification(
      String notificationId) async {
    try {
      await _apiService.deleteNotification(
          notificationId);

      _notifications.removeWhere(
          (n) => n.id == notificationId);

      notifyListeners();
    } catch (e) {
      _setError(e.toString());
    }
  }

  // ==========================
  // Clear Notifications
  // ==========================
  void clearNotifications() {
    _notifications = [];
    notifyListeners();
  }
}
