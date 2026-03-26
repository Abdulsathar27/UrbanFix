import 'package:dio/dio.dart';
import '../../core/constants/api_constants.dart';
import '../models/message_model.dart';
import 'dio_client.dart';

class MessageApiService {
  final Dio _dio = DioClient().dio;

  /// [chatStringId] is the "userId1_userId2" string chatId.
  Future<List<MessageModel>> getMessages(String chatStringId) async {
    try {
      final response = await _dio.get('${ApiConstants.messages}/$chatStringId');
      final List<dynamic> data = response.data as List<dynamic>;
      return data
          .map((json) => MessageModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw Exception('Failed to fetch messages: ${e.message}');
    }
  }
}
