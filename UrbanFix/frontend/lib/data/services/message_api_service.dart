import 'package:dio/dio.dart';

import '../../core/constants/api_constants.dart';
import '../models/message_model.dart';
import 'dio_client.dart';

class MessageApiService {
  final Dio _dio;

  MessageApiService(DioClient dioClient)
      : _dio = dioClient.dio;

  // ==========================================================
  // Get Messages By Chat ID
  // ==========================================================
  Future<List<MessageModel>> getMessages(
      String chatId) async {
    try {
      final response = await _dio.get(
        "${ApiConstants.messages}/$chatId",
      );

      final List<dynamic> data =
          response.data as List<dynamic>;

      return data
          .map((json) =>
              MessageModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw Exception(
          "Failed to fetch messages: ${e.message}");
    }
  }

  // ==========================================================
  // Send Message
  // ==========================================================
  Future<MessageModel> sendMessage({
    required String chatId,
    required String receiverId,
    required String message,
    String type = "text",
  }) async {
    try {
      final response = await _dio.post(
        ApiConstants.sendMessage,
        data: {
          "chatId": chatId,
          "receiverId": receiverId,
          "message": message,
          "type": type,
        },
      );

      return MessageModel.fromJson(
          response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw Exception(
          "Failed to send message: ${e.message}");
    }
  }

  // ==========================================================
  // Mark Message As Seen
  // ==========================================================
  Future<void> markMessageAsSeen(
      String messageId) async {
    try {
      await _dio.put(
        "${ApiConstants.messages}/$messageId/seen",
      );
    } on DioException catch (e) {
      throw Exception(
          "Failed to mark message as seen: ${e.message}");
    }
  }

  // ==========================================================
  // Delete Message
  // ==========================================================
  Future<void> deleteMessage(
      String messageId) async {
    try {
      await _dio.delete(
        "${ApiConstants.messages}/$messageId",
      );
    } on DioException catch (e) {
      throw Exception(
          "Failed to delete message: ${e.message}");
    }
  }
}
