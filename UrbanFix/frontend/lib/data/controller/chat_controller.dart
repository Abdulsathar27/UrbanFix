import 'package:flutter/material.dart';
import 'package:frontend/core/utils/socket_service.dart';
import 'package:frontend/data/models/chat_model.dart';
import 'package:frontend/data/models/message_model.dart';
import 'package:frontend/data/services/chat_api_service.dart';
import 'package:frontend/data/services/message_api_service.dart';

class ChatController extends ChangeNotifier {
  final ChatApiService _chatApiService = ChatApiService();
  final MessageApiService _messageApiService = MessageApiService();

  final TextEditingController messageInputController = TextEditingController();

  List<ChatModel> _chats = [];
  List<MessageModel> _messages = [];
  ChatModel? _selectedChat;
  bool _isLoading = false;
  bool _isSending = false;
  bool _chatsFetched = false;
  String? _errorMessage;

  List<ChatModel> get chats => _chats;
  ChatModel? get selectedChat => _selectedChat;
  List<MessageModel> get messages => _messages;
  bool get isLoading => _isLoading;
  bool get isSending => _isSending;
  bool get chatsFetched => _chatsFetched;
  String? get errorMessage => _errorMessage;

  @override
  void dispose() {
    messageInputController.dispose();
    super.dispose();
  }

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

 
  Future<void> fetchChats() async {
    try {
      _chatsFetched = true;
      _setLoading(true);
      _setError(null);
      _chats = await _chatApiService.getChats();
      notifyListeners();
    } catch (e) {
      _chatsFetched = false;
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

 
  static String buildChatStringId(String userId1, String userId2) {
    final ids = [userId1, userId2]..sort();
    return ids.join('_');
  }

  
  Future<void> openChat(String chatStringId, String currentUserId) async {
    try {
      _messages = [];
      _setLoading(true);
      _setError(null);

     
      final idx = _chats.indexWhere((c) => c.chatStringId == chatStringId);
      _selectedChat = idx != -1
          ? _chats[idx]
          : ChatModel.fromStringId(chatStringId);

      notifyListeners();

      
      SocketService().connect(currentUserId);
      SocketService().joinChat(chatStringId, currentUserId);

      
      SocketService().onReceiveMessage((data) {
        final msg = MessageModel.fromJson(data);
        if (msg.chatId == chatStringId) {
          // Replace matching temp message (id='') with the confirmed server message
          final tempIdx = _messages.indexWhere(
            (m) => m.id.isEmpty && m.senderId == msg.senderId && m.message == msg.message,
          );
          if (tempIdx != -1) {
            _messages[tempIdx] = msg;
          } else if (!_messages.any((m) => m.id == msg.id && m.id.isNotEmpty)) {
            _messages.insert(0, msg);
          }
          notifyListeners();
        }
      });

      await loadMessages(chatStringId);
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

 

  Future<void> loadMessages(String chatStringId) async {
    try {
      final fetched = await _messageApiService.getMessages(chatStringId);
      
      fetched.sort((a, b) =>
          (b.createdAt ?? DateTime.now()).compareTo(a.createdAt ?? DateTime.now()));
      _messages = fetched;
      notifyListeners();
    } catch (_) {
      
    }
  }

  
  Future<void> sendMessage({
    required String chatStringId,
    required String message,
    required String senderId,
  }) async {
    try {
      _isSending = true;
      _setError(null);
      notifyListeners();

      SocketService().sendMessage(
        chatStringId: chatStringId,
        text: message,
        senderId: senderId,
      );

      // Add message immediately so it shows without waiting for socket echo
      final tempMsg = MessageModel(
        id: '',
        chatId: chatStringId,
        senderId: senderId,
        message: message,
        type: 'text',
        isSeen: false,
        createdAt: DateTime.now(),
      );
      _messages.insert(0, tempMsg);

      // Update or add the chat in the list
      final index = _chats.indexWhere((c) => c.chatStringId == chatStringId);
      if (index != -1) {
        _chats[index] = _chats[index].copyWith(
          lastMessage: message,
          lastMessageTime: DateTime.now(),
        );
      } else if (_selectedChat != null) {
        // New chat — insert at top so it appears in the list immediately
        _chats.insert(
          0,
          _selectedChat!.copyWith(
            lastMessage: message,
            lastMessageTime: DateTime.now(),
          ),
        );
      }

      if (_selectedChat?.chatStringId == chatStringId) {
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

 
  Future<void> submitMessage({
    required String chatStringId,
    required String senderId,
  }) async {
    final text = messageInputController.text.trim();
    if (text.isEmpty) return;
    messageInputController.clear();
    await sendMessage(
        chatStringId: chatStringId, message: text, senderId: senderId);
  }

 

  Future<void> deleteChat(String chatStringId) async {
    try {
      _setLoading(true);
      _setError(null);
      await _chatApiService.deleteChat(chatStringId);
      _chats.removeWhere((c) => c.chatStringId == chatStringId);
      if (_selectedChat?.chatStringId == chatStringId) _selectedChat = null;
      notifyListeners();
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  void clearMessages() {
    if (_selectedChat != null) {
      SocketService().leaveChat(_selectedChat!.chatStringId);
      SocketService().offReceiveMessage();
    }
    _messages = [];
    _selectedChat = null;
    _chatsFetched = false;
    notifyListeners();
  }
}
