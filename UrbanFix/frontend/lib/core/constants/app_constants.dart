class AppConstants {
  // ===== App Info =====
  static const String appName = "UrbanFix";
  static const String appVersion = "1.0.0";

  // ===== Animation Durations =====
  static const Duration shortAnimation = Duration(milliseconds: 300);
  static const Duration mediumAnimation = Duration(milliseconds: 600);
  static const Duration longAnimation = Duration(milliseconds: 1000);

  // ===== Pagination =====
  static const int defaultPageSize = 10;

  // ===== Layout =====
  static const double defaultPadding = 16.0;
  static const double defaultBorderRadius = 12.0;
  static const double cardBorderRadius = 16.0;

  // ===== Timeouts =====
  static const int requestTimeoutSeconds = 15;

  // ===== Storage Keys (for SharedPreferences later) =====
  static const String tokenKey = "auth_token";
  static const String refreshTokenKey = "refresh_token";
  static const String themeKey = "app_theme_mode";

  // ===== Default Values =====
  static const String defaultProfileImage =
      "https://via.placeholder.com/150";
}
