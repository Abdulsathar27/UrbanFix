import 'package:frontend/data/services/dio_client.dart';
import 'package:frontend/data/services/message_api_service.dart';
import '../models/message_model.dart';

class MessageRepository {
  final MessageApiService _apiService;

  MessageRepository()
      : _apiService = MessageApiService(DioClient());

  // ==========================
  // Get Messages By Chat
  // ==========================
  Future<List<MessageModel>> getMessages(
      String chatId) async {
    return await _apiService.getMessages(chatId);
  }

  // ==========================
  // Send Message
  // ==========================
  Future<MessageModel> sendMessage({
    required String chatId,
    required String receiverId,
    required String message,
    String type = "text",
  }) async {
    return await _apiService.sendMessage(
      chatId: chatId,
      receiverId: receiverId,
      message: message,
      type: type,
    );
  }

  // ==========================
  // Mark Message As Seen
  // ==========================
  Future<void> markMessageAsSeen(
      String messageId) async {
    await _apiService.markMessageAsSeen(messageId);
  }

  // ==========================
  // Delete Message
  // ==========================
  Future<void> deleteMessage(String messageId) async {
    await _apiService.deleteMessage(messageId);
  }
}
