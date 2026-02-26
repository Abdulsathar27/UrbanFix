import 'package:flutter/material.dart';
import 'package:frontend/data/models/chat_model.dart';
import 'package:frontend/data/models/message_model.dart';
import 'package:frontend/data/services/chat_api_service.dart';
import 'package:frontend/data/services/message_api_service.dart';

class ChatController extends ChangeNotifier {
  // ==========================
  // 🔹 ADDED: Make service final (best practice)
  // ==========================
  final ChatApiService chatApiService = ChatApiService();
  final MessageApiService messageApiService = MessageApiService();

  List<ChatModel> _chats = [];
  List<MessageModel> _messages = [];
  ChatModel? _selectedChat;
  bool _isLoading = false;
  String? _errorMessage;

  // ==========================
  // Getters
  // ==========================
  List<ChatModel> get chats => _chats;
  ChatModel? get selectedChat => _selectedChat;
  List<MessageModel> get messages => _messages; 
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // ==========================
  // Private Helpers
  // ==========================
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners(); // already correct
  }

  void _setError(String? message) {
    _errorMessage = message;
    notifyListeners(); // already correct
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

      _chats = await chatApiService.getChats();

      // 🔹 ADDED: notify UI after updating list
      notifyListeners();
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

      _selectedChat = await chatApiService.getChatById(chatId);

      // 🔹 ADDED: notify UI after setting selected chat
      notifyListeners();
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  // ==========================
  // 🔹 ADDED: Set Selected Chat manually
  // (Useful when opening chat screen)
  // ==========================
  void setSelectedChat(ChatModel chat) {
    _selectedChat = chat;
    notifyListeners();
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

      final newChat = await chatApiService.createChat(
        jobId: jobId,
        participantIds: participantIds,
      );

      _chats.add(newChat);

      // 🔹 ADDED: notify after adding
      notifyListeners();
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
      await chatApiService.markChatAsRead(chatId);

      final index = _chats.indexWhere((chat) => chat.id == chatId);

      if (index != -1) {
        _chats[index] = _chats[index].copyWith(unreadCount: 0);
        notifyListeners();
      }
    } catch (e) {
      _setError(e.toString());
    }
  }

  // ==========================
  // 🔹 ADDED: Send Message (Very Important for Chat Screen)
  // ==========================
   Future<void> sendMessage({
    required String chatId,
    required String message,
  }) async {
    try {
      _setError(null);
      
      await chatApiService.sendMessage(
        chatId: chatId,
        message: message,
      );
      
      // Reload messages after sending
      await loadMessages(chatId);
      
      // Also update the chat list if needed
      final updatedChat = await chatApiService.getChatById(chatId);
      _selectedChat = updatedChat;
      
      final index = _chats.indexWhere((c) => c.id == chatId);
      if (index != -1) {
        _chats[index] = updatedChat;
      }
      
      notifyListeners();
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

      await chatApiService.deleteChat(chatId);

      _chats.removeWhere((chat) => chat.id == chatId);

      if (_selectedChat?.id == chatId) {
        _selectedChat = null;
      }

      // 🔹 ADDED: notify after deletion
      notifyListeners();
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }
  Future<void> loadMessages(String chatId) async {
    try {
      // Fetch messages from API
      final fetchedMessages = await messageApiService.getMessages(chatId);
      _messages = fetchedMessages;
      notifyListeners();
    } catch (e) {
      // Handle error
    }
  }
}