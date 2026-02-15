import 'package:flutter/material.dart';

import '../../data/models/chat_model.dart';
import '../../data/repositories/chat_repository.dart';

class ChatController extends ChangeNotifier {
  final ChatRepository _repository = ChatRepository();

  List<ChatModel> _chats = [];
  ChatModel? _selectedChat;
  bool _isLoading = false;
  String? _errorMessage;

  // ==========================
  // Getters
  // ==========================
  List<ChatModel> get chats => _chats;
  ChatModel? get selectedChat => _selectedChat;
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
  // Fetch All Chats
  // ==========================
  Future<void> fetchChats() async {
    try {
      _setLoading(true);
      _setError(null);

      final data = await _repository.getChats();
      _chats = data;
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  // ==========================
  // Fetch Chat By ID
  // ==========================
  Future<void> fetchChatById(String chatId) async {
    try {
      _setLoading(true);
      _setError(null);

      final chat = await _repository.getChatById(chatId);
      _selectedChat = chat;
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  // ==========================
  // Create Chat
  // ==========================
  Future<void> createChat({
    required String jobId,
    required List<String> participantIds,
  }) async {
    try {
      _setLoading(true);
      _setError(null);

      final newChat = await _repository.createChat(
        jobId: jobId,
        participantIds: participantIds,
      );

      _chats.add(newChat);
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  // ==========================
  // Mark Chat As Read
  // ==========================
  Future<void> markChatAsRead(String chatId) async {
    try {
      await _repository.markChatAsRead(chatId);

      final index =
          _chats.indexWhere((chat) => chat.id == chatId);

      if (index != -1) {
        final updatedChat =
            _chats[index].copyWith(unreadCount: 0);
        _chats[index] = updatedChat;
        notifyListeners();
      }
    } catch (e) {
      _setError(e.toString());
    }
  }

  // ==========================
  // Delete Chat
  // ==========================
  Future<void> deleteChat(String chatId) async {
    try {
      _setLoading(true);
      _setError(null);

      await _repository.deleteChat(chatId);

      _chats.removeWhere((chat) => chat.id == chatId);

      if (_selectedChat?.id == chatId) {
        _selectedChat = null;
      }
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }
}
