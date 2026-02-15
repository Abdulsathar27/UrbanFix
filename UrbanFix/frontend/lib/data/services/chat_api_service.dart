import 'package:dio/dio.dart';

import '../../core/constants/api_constants.dart';
import '../models/chat_model.dart';
import 'dio_client.dart';

class ChatApiService {
  final Dio _dio;

  ChatApiService(DioClient dioClient)
      : _dio = dioClient.dio;

  // ==========================
  // Get All Chats
  // ==========================
  Future<List<ChatModel>> getChats() async {
    final response = await _dio.get(
      ApiConstants.chats,
    );

    final List data = response.data;

    return data
        .map((json) => ChatModel.fromJson(json))
        .toList();
  }

  // ==========================
  // Get Chat By ID
  // ==========================
  Future<ChatModel> getChatById(String chatId) async {
    final response = await _dio.get(
      "${ApiConstants.chats}/$chatId",
    );

    return ChatModel.fromJson(response.data);
  }

  // ==========================
  // Create Chat
  // ==========================
  Future<ChatModel> createChat({
    required String jobId,
    required List<String> participantIds,
  }) async {
    final response = await _dio.post(
      ApiConstants.createChat,
      data: {
        "jobId": jobId,
        "participantIds": participantIds,
      },
    );

    return ChatModel.fromJson(response.data);
  }

  // ==========================
  // Mark Chat As Read
  // ==========================
  Future<void> markChatAsRead(String chatId) async {
    await _dio.put(
      "${ApiConstants.chats}/$chatId/read",
    );
  }

  // ==========================
  // Delete Chat
  // ==========================
  Future<void> deleteChat(String chatId) async {
    await _dio.delete(
      "${ApiConstants.chats}/$chatId",
    );
  }
}
