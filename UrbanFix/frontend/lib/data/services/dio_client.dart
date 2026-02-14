import 'package:dio/dio.dart';
import '../../core/constants/api_constants.dart';

class DioClient {
  late final Dio _dio;

  DioClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.devBaseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
      ),
    );

    _initializeInterceptors();
  }

  Dio get dio => _dio;

  void _initializeInterceptors() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // TODO: Attach token here later
          // Example:
          // final token = TokenStorage.getToken();
          // if (token != null) {
          //   options.headers["Authorization"] = "Bearer $token";
          // }

          return handler.next(options);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (DioException error, handler) {
          // Global error handling

          if (error.response?.statusCode == 401) {
            // TODO: Handle unauthorized (auto logout later)
          }

          return handler.next(error);
        },
      ),
    );

    // Logging interceptor (Only for development)
    _dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        error: true,
      ),
    );
  }
}
