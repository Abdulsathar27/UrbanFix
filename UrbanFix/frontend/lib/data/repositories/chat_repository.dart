import 'package:frontend/data/services/chat_api_service.dart';
import 'package:frontend/data/services/dio_client.dart';
import '../models/chat_model.dart';

class ChatRepository {
  final ChatApiService _apiService;

  ChatRepository()
      : _apiService = ChatApiService(DioClient());

  // ==========================
  // Get All Chats
  // ==========================
  Future<List<ChatModel>> getChats() async {
    return await _apiService.getChats();
  }

  // ==========================
  // Get Chat By ID
  // ==========================
  Future<ChatModel> getChatById(String chatId) async {
    return await _apiService.getChatById(chatId);
  }

  // ==========================
  // Create Chat
  // ==========================
  Future<ChatModel> createChat({
    required String jobId,
    required List<String> participantIds,
  }) async {
    return await _apiService.createChat(
      jobId: jobId,
      participantIds: participantIds,
    );
  }

  // ==========================
  // Mark Chat As Read
  // ==========================
  Future<void> markChatAsRead(String chatId) async {
    await _apiService.markChatAsRead(chatId);
  }

  // ==========================
  // Delete Chat
  // ==========================
  Future<void> deleteChat(String chatId) async {
    await _apiService.deleteChat(chatId);
  }
}
