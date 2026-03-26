class ApiConstants {
  static const String devBaseUrl = "http://10.0.2.2:5000/api";
  static const String socketUrl  = "http://10.0.2.2:5000";

  static const String prodBaseUrl = "https://api.urbanfix.com/api";

  static const String baseUrl = devBaseUrl;

  static const String apiVersion = "v1";

  static const String login = "/auth/login";
  static const String register = "/auth/register";
  static const String logout = "/auth/logout";
  static const String refreshToken = "/auth/refresh";
  static const String verifyEmail = "/auth/verify-email";
  static const String resendEmailOtp = "/auth/resend-email-otp";

  static const String userProfile = "/profile/me";
  static const String updateProfile = "/profile/save";

  static const String appointments = "/appointments";
  static const String createAppointment = "/appointments/create";

  static const String jobs = "/jobs";
  static const String jobDetails = "/jobs/details";

  static const String chats = "/chats";
  static const String createChat = "/chats/create";

  static const String messages = "/messages";
  static const String sendMessage = "/messages/send";

  static const String notifications = "/notifications";

  static const String reports = "/reports";
}
