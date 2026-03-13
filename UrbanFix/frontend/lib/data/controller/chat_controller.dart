import 'package:flutter/material.dart';
import 'package:frontend/data/models/chat_model.dart';
import 'package:frontend/data/models/message_model.dart';
import 'package:frontend/data/services/chat_api_service.dart';
import 'package:frontend/data/services/message_api_service.dart';

class ChatController extends ChangeNotifier {
  final ChatApiService _chatApiService = ChatApiService();
  final MessageApiService _messageApiService = MessageApiService();

  List<ChatModel> _chats = [];
  List<MessageModel> _messages = [];
  ChatModel? _selectedChat;
  bool _isLoading = false;
  bool _isSending = false; 
  String? _errorMessage;

  // ==========================
  // Getters
  // ==========================
  List<ChatModel> get chats => _chats;
  ChatModel? get selectedChat => _selectedChat;
  List<MessageModel> get messages => _messages;
  bool get isLoading => _isLoading;
  bool get isSending => _isSending;
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
      _chats = await _chatApiService.getChats();
      notifyListeners();
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  // ==========================
  // Fetch Chat By ID + load messages
  // FIX: also loads messages immediately after fetching chat
  // ==========================
  Future<void> fetchChatById(String chatId) async {
    try {
      _setLoading(true);
      _setError(null);

      final chats = await _chatApiService.getChatById(chatId);

      if (chats.isEmpty) {
        _selectedChat = null;
        _setError('Chat not found');
      } else {
        _selectedChat = chats.first;
        // FIX: Load messages right after selecting chat
        await loadMessages(chatId);
      }

      notifyListeners();
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  // ==========================
  // Set Selected Chat manually
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

      final newChat = await _chatApiService.createChat(jobId, participantIds);
      _chats.add(newChat.first);
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
      await _chatApiService.markChatAsRead(chatId);

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
  // Send Message
  // FIX: uses _isSending instead of _isLoading so the full screen
  // doesn't show a loading spinner while typing/sending
  // FIX: appends the new message locally for instant UI feedback
  // ==========================
  Future<void> sendMessage({
    required String chatId,
    required String message,
  }) async {
    try {
      _isSending = true;
      _setError(null);
      notifyListeners();

      final sentMessage = await _chatApiService.sendMessage(chatId, message);

      // Append new message at the front (list is reversed in UI)
      _messages = [sentMessage, ..._messages];

      // Refresh messages from server to stay in sync
      await loadMessages(chatId);

      // Update last message preview in chat list
      final index = _chats.indexWhere((c) => c.id == chatId);
      if (index != -1) {
        _chats[index] = _chats[index].copyWith(
          lastMessage: message,
          lastMessageTime: DateTime.now(),
        );
      }

      // Update selectedChat last message too
      if (_selectedChat?.id == chatId) {
        _selectedChat = _selectedChat!.copyWith(
          lastMessage: message,
          lastMessageTime: DateTime.now(),
        );
      }

      notifyListeners();
    } catch (e) {
      _setError(e.toString());
    } finally {
      _isSending = false;
      notifyListeners();
    }
  }

  // ==========================
  // Delete Chat
  // ==========================
  Future<void> deleteChat(String chatId) async {
    try {
      _setLoading(true);
      _setError(null);

      await _chatApiService.deleteChat(chatId);
      _chats.removeWhere((chat) => chat.id == chatId);

      if (_selectedChat?.id == chatId) {
        _selectedChat = null;
      }

      notifyListeners();
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  // ==========================
  // Load Messages
  // FIX: errors are now surfaced via _setError instead of silently swallowed
  // ==========================
  Future<void> loadMessages(String chatId) async {
    try {
      final fetchedMessages = await _messageApiService.getMessages(chatId);
      _messages = fetchedMessages;
      notifyListeners();
    } catch (e) {
      _setError(e.toString());
    }
  }

  // ==========================
  // Clear messages on screen exit
  // ==========================
  void clearMessages() {
    _messages = [];
    _selectedChat = null;
    notifyListeners();
  }
}