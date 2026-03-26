import 'package:shared_preferences/shared_preferences.dart';

class TokenStore {
  static const String _tokenKey = 'auth_token';
  static String? _token;

  static String? get token => _token;

  // Sync setter for immediate in-memory use (Dio interceptor), saves to disk async
  static void setToken(String? value) {
    _token = value;
    if (value != null) {
      SharedPreferences.getInstance().then((prefs) => prefs.setString(_tokenKey, value));
    }
  }

  // Call once at app startup to restore token from disk
  static Future<void> loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString(_tokenKey);
  }

  static Future<void> clear() async {
    _token = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }
}
