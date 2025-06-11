import 'dart:convert';

class Auth {
  static String? username;
  static String? password;

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
}
