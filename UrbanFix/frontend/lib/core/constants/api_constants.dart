class ApiConstants {
  // ====== Environment Base URLs ======

  // Development
  static const String devBaseUrl = "http://10.0.2.2:5000/api";

  // Production (change later when deploying)
  static const String prodBaseUrl = "https://api.urbanfix.com/api";

  // Current Active Base URL
  static const String baseUrl = devBaseUrl;

  // ====== API Version ======
  static const String apiVersion = "v1";

  // ====== Authentication ======
  static const String login = "/auth/login";
  static const String register = "/auth/register";
  static const String logout = "/auth/logout";
  static const String refreshToken = "/auth/refresh";
  static const String verifyEmail = "/auth/verify-email";
  static const String resendEmailOtp = "/auth/resend-email-otp";


  // ====== User ======
  static const String userProfile = "/profile/me";
  static const String updateProfile = "/profile/save";

  // ====== Appointment ======
  static const String appointments = "/appointments";
  static const String createAppointment = "/appointments/create";

  // ====== Job ======
  static const String jobs = "/jobs";
  static const String jobDetails = "/jobs/details";

  // ====== Chat ======
  static const String chats = "/chats";
  static const String createChat = "/chats/create";

  // ====== Message ======
  static const String messages = "/messages";
  static const String sendMessage = "/messages/send";

  // ====== Notification ======
  static const String notifications = "/notifications";

  // ====== Report ======
  static const String reports = "/reports";
}
