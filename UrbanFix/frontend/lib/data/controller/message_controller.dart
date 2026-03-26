import 'package:flutter/material.dart';
import 'package:frontend/data/models/message_model.dart';
import 'package:frontend/data/services/message_api_service.dart';

class MessageController extends ChangeNotifier {
  MessageApiService messageApiService = MessageApiService();

  List<MessageModel> _messages = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<MessageModel> get messages => _messages;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

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

  Future<void> fetchMessages(String chatStringId) async {
    try {
      _setLoading(true);
      _setError(null);
      final data = await messageApiService.getMessages(chatStringId);
      data.sort((a, b) =>
          (a.createdAt ?? DateTime.now()).compareTo(b.createdAt ?? DateTime.now()));
      _messages = data;
      notifyListeners();
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  void clearMessages() {
    _messages = [];
    notifyListeners();
  }
}
