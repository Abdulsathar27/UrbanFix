import 'package:dio/dio.dart';

import '../../core/constants/api_constants.dart';
import '../models/chat_model.dart';
import 'dio_client.dart';

class ChatApiService {
  final Dio _dio = DioClient().dio;

  

  // ==========================================================
  // Get All Chats
  // ==========================================================
  Future<List<ChatModel>> getChats() async {
    try {
      final response = await _dio.get(ApiConstants.chats);

      final List<dynamic> data =
          response.data as List<dynamic>;

      return data
          .map((json) =>
              ChatModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw Exception("Failed to fetch chats: ${e.message}");
    }
  }

  // ==========================================================
  // Get Chat By ID
  // ==========================================================
  Future<ChatModel> getChatById(String chatId) async {
    try {
      final response = await _dio.get(
        "${ApiConstants.chats}/$chatId",
      );

      return ChatModel.fromJson(
          response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw Exception("Failed to fetch chat: ${e.message}");
    }
  }

  // ==========================================================
  // Create Chat
  // ==========================================================
  Future<ChatModel> createChat({
    required String jobId,
    required List<String> participantIds,
  }) async {
    try {
      final response = await _dio.post(
        ApiConstants.createChat,
        data: {
          "jobId": jobId,
          "participantIds": participantIds,
        },
      );

      return ChatModel.fromJson(
          response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw Exception("Failed to create chat: ${e.message}");
    }
  }

  // ==========================================================
  // Mark Chat As Read
  // ==========================================================
  Future<void> markChatAsRead(String chatId) async {
    try {
      await _dio.put(
        "${ApiConstants.chats}/$chatId/read",
      );
    } on DioException catch (e) {
      throw Exception("Failed to mark chat as read: ${e.message}");
    }
  }

  // ==========================================================
  // Delete Chat
  // ==========================================================
  Future<void> deleteChat(String chatId) async {
    try {
      await _dio.delete(
        "${ApiConstants.chats}/$chatId",
      );
    } on DioException catch (e) {
      throw Exception("Failed to delete chat: ${e.message}");
    }
  }
}
