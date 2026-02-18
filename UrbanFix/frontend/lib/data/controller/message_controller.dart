import 'package:flutter/material.dart';

import '../../../../data/models/message_model.dart';
import '../../../../data/services/message_api_service.dart';

class MessageController extends ChangeNotifier {
  final MessageApiService _apiService;

  MessageController(this._apiService);

  List<MessageModel> _messages = [];
  bool _isLoading = false;
  String? _errorMessage;

  // ==========================
  // Getters
  // ==========================
  List<MessageModel> get messages => _messages;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

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
  // Fetch Messages For Chat
  // ==========================
  Future<void> fetchMessages(String chatId) async {
    try {
      _setLoading(true);
      _setError(null);

      final data =
          await _apiService.getMessages(chatId);

      // Sort messages by time (oldest first)
      data.sort((a, b) =>
          (a.createdAt ?? DateTime.now())
              .compareTo(b.createdAt ?? DateTime.now()));

      _messages = data;
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  // ==========================
  // Send Message
  // ==========================
  Future<void> sendMessage({
    required String chatId,
    required String receiverId,
    required String message,
    String type = "text",
  }) async {
    try {
      final newMessage =
          await _apiService.sendMessage(
        chatId: chatId,
        receiverId: receiverId,
        message: message,
        type: type,
      );

      _messages.add(newMessage);
      notifyListeners();
    } catch (e) {
      _setError(e.toString());
    }
  }

  // ==========================
  // Mark Message As Seen
  // ==========================
  Future<void> markMessageAsSeen(
      String messageId) async {
    try {
      await _apiService.markMessageAsSeen(
          messageId);

      final index = _messages.indexWhere(
          (message) => message.id == messageId);

      if (index != -1) {
        _messages[index] =
            _messages[index]
                .copyWith(isSeen: true);
        notifyListeners();
      }
    } catch (e) {
      _setError(e.toString());
    }
  }

  // ==========================
  // Delete Message
  // ==========================
  Future<void> deleteMessage(
      String messageId) async {
    try {
      await _apiService.deleteMessage(
          messageId);

      _messages.removeWhere(
          (message) => message.id == messageId);

      notifyListeners();
    } catch (e) {
      _setError(e.toString());
    }
  }

  // ==========================
  // Clear Messages
  // ==========================
  void clearMessages() {
    _messages = [];
    notifyListeners();
  }
}
