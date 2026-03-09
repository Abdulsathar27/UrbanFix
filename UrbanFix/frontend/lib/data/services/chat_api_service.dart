import 'package:dio/dio.dart';

import '../../core/constants/api_constants.dart';
import '../models/chat_model.dart';
import '../models/message_model.dart';
import 'dio_client.dart';

class ChatApiService {
  final Dio _dio = DioClient().dio;

  // ==========================================================
  // Get All Chats
  // ==========================================================
  Future<List<ChatModel>> getChats() async {
    try {
      final response = await _dio.get(ApiConstants.chats);
      final List<dynamic> data = response.data as List<dynamic>;
      return data
          .map((json) => ChatModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw Exception('Failed to fetch chats: ${e.message}');
    }
  }

  // ==========================================================
  // Get Chat By ID
  // FIX: API likely returns a single object, not a list.
  // Wrapped in a list to maintain controller compatibility.
  // ==========================================================
  Future<List<ChatModel>> getChatById(String chatId) async {
    try {
      final response = await _dio.get('${ApiConstants.chats}/$chatId');

      // Handle both single object and list responses
      if (response.data is List) {
        final List<dynamic> data = response.data as List<dynamic>;
        return data
            .map((json) => ChatModel.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        return [ChatModel.fromJson(response.data as Map<String, dynamic>)];
      }
    } on DioException catch (e) {
      throw Exception('Failed to fetch chat: ${e.message}');
    }
  }

  // ==========================================================
  // Create Chat
  // ==========================================================
  Future<List<ChatModel>> createChat(
      String jobId, List<String> participantIds) async {
    try {
      final response = await _dio.post(
        ApiConstants.createChat,
        data: {'jobId': jobId, 'participantIds': participantIds},
      );
      final List<dynamic> data = response.data['chats'] as List<dynamic>;
      return data
          .map((json) => ChatModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw Exception('Failed to create chat: ${e.message}');
    }
  }

  // ==========================================================
  // Mark Chat As Read
  // ==========================================================
  Future<void> markChatAsRead(String chatId) async {
    try {
      await _dio.put('${ApiConstants.chats}/$chatId/read');
    } on DioException catch (e) {
      throw Exception('Failed to mark chat as read: ${e.message}');
    }
  }

  // ==========================================================
  // Delete Chat
  // ==========================================================
  Future<void> deleteChat(String chatId) async {
    try {
      await _dio.delete('${ApiConstants.chats}/$chatId');
    } on DioException catch (e) {
      throw Exception('Failed to delete chat: ${e.message}');
    }
  }

  // ==========================================================
  // Send Message
  // FIX: Returns MessageModel, not ChatModel — sending a message
  // produces a message response, not a chat response.
  // ==========================================================
  Future<MessageModel> sendMessage(String chatId, String message) async {
    try {
      final response = await _dio.post(
        '${ApiConstants.chats}/$chatId/messages',
        data: {'message': message},
      );
      return MessageModel.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw Exception('Failed to send message: ${e.message}');
    }
  }
}