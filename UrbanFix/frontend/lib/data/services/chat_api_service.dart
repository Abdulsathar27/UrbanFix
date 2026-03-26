import 'package:dio/dio.dart';
import '../../core/constants/api_constants.dart';
import '../models/chat_model.dart';
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

  /// [chatStringId] is the "userId1_userId2" string, not a MongoDB _id.
  Future<void> deleteChat(String chatStringId) async {
    try {
      await _dio.delete('${ApiConstants.chats}/$chatStringId');
    } on DioException catch (e) {
      throw Exception('Failed to delete chat: ${e.message}');
    }
  }
}
