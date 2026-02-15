import 'package:dio/dio.dart';

import '../../core/constants/api_constants.dart';
import '../models/message_model.dart';
import 'dio_client.dart';

class MessageApiService {
  final Dio _dio;

  MessageApiService(DioClient dioClient)
      : _dio = dioClient.dio;

  // ==========================
  // Get Messages By Chat ID
  // ==========================
  Future<List<MessageModel>> getMessages(
      String chatId) async {
    final response = await _dio.get(
      "${ApiConstants.messages}/$chatId",
    );

    final List data = response.data;

    return data
        .map((json) => MessageModel.fromJson(json))
        .toList();
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
    final response = await _dio.post(
      ApiConstants.sendMessage,
      data: {
        "chatId": chatId,
        "receiverId": receiverId,
        "message": message,
        "type": type,
      },
    );

    return MessageModel.fromJson(response.data);
  }

  // ==========================
  // Mark Message As Seen
  // ==========================
  Future<void> markMessageAsSeen(String messageId) async {
    await _dio.put(
      "${ApiConstants.messages}/$messageId/seen",
    );
  }

  // ==========================
  // Delete Message
  // ==========================
  Future<void> deleteMessage(String messageId) async {
    await _dio.delete(
      "${ApiConstants.messages}/$messageId",
    );
  }
}
