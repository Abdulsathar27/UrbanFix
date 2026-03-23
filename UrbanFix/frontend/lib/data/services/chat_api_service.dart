import 'package:dio/dio.dart';

import '../../core/constants/api_constants.dart';
import '../models/chat_model.dart';
import '../models/message_model.dart';
import 'dio_client.dart';

class ChatApiService {
  final Dio _dio = DioClient().dio;
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
  Future<List<ChatModel>> getChatById(String chatId) async {
    try {
      final response = await _dio.get('${ApiConstants.chats}/$chatId');
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
  Future<void> markChatAsRead(String chatId) async {
    try {
      await _dio.put('${ApiConstants.chats}/$chatId/read');
    } on DioException catch (e) {
      throw Exception('Failed to mark chat as read: ${e.message}');
    }
  }

 
  Future<void> deleteChat(String chatId) async {
    try {
      await _dio.delete('${ApiConstants.chats}/$chatId');
    } on DioException catch (e) {
      throw Exception('Failed to delete chat: ${e.message}');
    }
  }

  
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