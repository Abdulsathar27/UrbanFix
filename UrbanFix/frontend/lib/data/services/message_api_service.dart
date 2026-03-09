import 'package:dio/dio.dart';

import '../../core/constants/api_constants.dart';
import '../models/message_model.dart';
import 'dio_client.dart';

class MessageApiService {
  final Dio _dio = DioClient().dio;

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
  Future<List<MessageModel>> sendMessage(String chatId,String receiverId,String message,String type) async {
    try {
      final response = await _dio.post("${ApiConstants.sendMessage}/sendMessage",
        data: {
          "chatId": chatId,
          "receiverId": receiverId,
          "message": message,
          "type": type
        }
      );
      final List<dynamic> data = response.data as List<dynamic>;

      return data
          .map((json) => MessageModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw Exception(
          "Failed to send message: ${e.message}");
    }
  }

  // ==========================================================
  // Mark Message As Seen
  // ==========================================================
  Future<List<MessageModel>> markMessageAsSeen(
      String messageId) async {
    try {
      final response = await _dio.put(
        "${ApiConstants.messages}/$messageId/seen",
      );
      final List<dynamic> data = response.data as List<dynamic>;
      return data
          .map((json) => MessageModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw Exception(
          "Failed to mark message as seen: ${e.message}");
    }
  }

  // ==========================================================
  // Delete Message
  // ==========================================================
  Future<List<MessageModel>> deleteMessage(
      String messageId) async {
    try {
      final response = await _dio.delete(
        "${ApiConstants.messages}/$messageId",
      );
      final List<dynamic> data = response.data as List<dynamic>;
      return data
          .map((json) => MessageModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw Exception(
          "Failed to delete message: ${e.message}");
    }
  }
}
