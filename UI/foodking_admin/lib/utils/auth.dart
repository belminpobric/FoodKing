import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Auth {
  static String? username;
  static String? password;

  static const _keyUsername = 'fk_username';
  static const _keyPassword = 'fk_password';

  static Map<String, String> createAuthHeaders() {
    String username = Auth.username ?? "admin";
    String password = Auth.password ?? "admin";

    String basicAuth =
        "Basic ${base64Encode(utf8.encode('$username:$password'))}";

    return {
      "Content-Type": "application/json",
      "Accept": "text/plain",
      "Authorization": basicAuth,
    };
  }

  static Future<void> saveCredentials(String user, String pass) async {
    username = user;
    password = pass;
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_keyUsername, user);
      await prefs.setString(_keyPassword, pass);
    } catch (_) {}
  }

  static Future<bool> loadCredentials() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final u = prefs.getString(_keyUsername);
      final p = prefs.getString(_keyPassword);
      if (u != null && p != null) {
        username = u;
        password = p;
        return true;
      }
    } catch (_) {}
    return false;
  }

  static Future<void> clearCredentials() async {
    username = null;
    password = null;
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_keyUsername);
      await prefs.remove(_keyPassword);
    } catch (_) {}
  }
}
