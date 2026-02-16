import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:foodking_admin/providers/UserProvider.dart';

// Manages current user's roles and credentials

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

  // Roles for the currently authenticated user (names only)
  static List<String> currentRoles = [];

  static Future<void> fetchRolesForCurrentUser() async {
    currentRoles = [];
    if (username == null) return;
    try {
      final provider = UserProvider();
      final data = await provider.getUsers(
        UserName: username,
        isRoleIncluded: true,
      );

      final List<dynamic> usersJson = data['result'] ?? [];
      if (usersJson.isEmpty) return;

      final userJson = usersJson.first;
      if (userJson['userHasRoles'] is List) {
        for (final r in (userJson['userHasRoles'] as List)) {
          try {
            final name = r?['role']?['name']?.toString();
            if (name != null && name.isNotEmpty) currentRoles.add(name);
          } catch (_) {}
        }
      }
    } catch (_) {
      // ignore errors - roles remain empty
    }
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
        // populate roles for the loaded credentials
        try {
          await fetchRolesForCurrentUser();
        } catch (_) {}
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
