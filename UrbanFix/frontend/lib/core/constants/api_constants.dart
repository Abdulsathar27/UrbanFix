import 'package:flutter/foundation.dart';

class ApiConstants {
  // Optional runtime overrides:
  // flutter run --dart-define=API_BASE_URL=http://192.168.1.8:5000/api
  // flutter run --dart-define=SOCKET_URL=http://192.168.1.8:5000
  static const String _apiBaseUrlFromEnv = String.fromEnvironment(
    'API_BASE_URL',
  );
  static const String _socketUrlFromEnv = String.fromEnvironment('SOCKET_URL');

  static const String devBaseUrl = 'http://10.0.2.2:5000/api';
  static const String prodBaseUrl = 'https://api.urbanfix.com/api';

  static const String _localApiBaseUrl = 'http://localhost:5000/api';
  static const String _localSocketUrl = 'http://localhost:5000';
  static const String _androidSocketUrl = 'http://10.0.2.2:5000';

  // On Android emulator use 10.0.2.2, on web/desktop/iOS simulator use localhost,
  // and allow overrides via --dart-define for physical devices or remote backends.
  static String get baseUrl {
    if (_apiBaseUrlFromEnv.isNotEmpty) return _apiBaseUrlFromEnv;
    if (kIsWeb) return _localApiBaseUrl;
    if (defaultTargetPlatform == TargetPlatform.android) return devBaseUrl;
    return _localApiBaseUrl;
  }

  static String get socketUrl {
    if (_socketUrlFromEnv.isNotEmpty) return _socketUrlFromEnv;
    if (kIsWeb) return _localSocketUrl;
    if (defaultTargetPlatform == TargetPlatform.android) return _androidSocketUrl;
    return _localSocketUrl;
  }

  static const String apiVersion = 'v1';

  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String logout = '/auth/logout';
  static const String refreshToken = '/auth/refresh';
  static const String verifyEmail = '/auth/verify-email';
  static const String resendEmailOtp = '/auth/resend-email-otp';

  static const String userProfile = '/profile/me';
  static const String updateProfile = '/profile/save';

  static const String appointments = '/appointments';
  static const String createAppointment = '/appointments/create';

  static const String jobs = '/jobs';
  static const String jobDetails = '/jobs/details';

  static const String chats = '/chats';
  static const String createChat = '/chats/create';

  static const String messages = '/messages';
  static const String sendMessage = '/messages/send';

  static const String notifications = '/notifications';

  static const String reports = '/reports';
}
