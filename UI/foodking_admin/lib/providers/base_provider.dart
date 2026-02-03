import 'dart:convert';
import 'package:foodking_admin/utils/auth.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class ValidationException implements Exception {
  final dynamic errors;
  ValidationException(this.errors);
  @override
  String toString() => 'ValidationException: $errors';
}

abstract class BaseProvider with ChangeNotifier {
  static String? _baseUrl;
  final String endpoint;

  BaseProvider(this.endpoint) {
    _baseUrl = const String.fromEnvironment("baseUrl",
        defaultValue: "http://localhost:7003/");
  }

  Future<dynamic> get({Map<String, dynamic>? queryParams}) async {
    var url = "$_baseUrl$endpoint";

    if (queryParams != null && queryParams.isNotEmpty) {
      final params =
          queryParams.map((key, value) => MapEntry(key, value.toString()));
      url += "?${Uri(queryParameters: params).query}";
    }

    print("Request URL: $url"); // Debug print
    var uri = Uri.parse(url);
    var headers = createHeaders();

    var response = await http.get(uri, headers: headers);
    print("Response status: ${response.statusCode}");
    print("Response body: ${response.body}");

    if (response.statusCode < 299) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 400) {
      try {
        final data = jsonDecode(response.body);
        throw ValidationException(data);
      } catch (_) {
        throw Exception('Bad Request');
      }
    } else if (response.statusCode == 401) {
      throw Exception("Unauthorized");
    } else {
      throw Exception("Something bad happened please try again");
    }
  }

  Future<dynamic> post(Map<String, dynamic> obj) async {
    var url = "$_baseUrl$endpoint";

    print("Request URL: $url"); // Debug print
    var uri = Uri.parse(url);
    var headers = createHeaders();

    var response =
        await http.post(uri, headers: headers, body: jsonEncode(obj));
    print("Response status: ${response.statusCode}");
    print("Response body: ${response.body}");

    if (response.statusCode < 299) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 400) {
      try {
        final data = jsonDecode(response.body);
        throw ValidationException(data);
      } catch (_) {
        throw Exception('Bad Request');
      }
    } else if (response.statusCode == 401) {
      throw Exception("Unauthorized");
    } else {
      throw Exception("Something bad happened please try again");
    }
  }

  Future<dynamic> postToPath(String path, {Map<String, dynamic>? body}) async {
    var url = "$_baseUrl$path";

    print("Request URL: $url"); // Debug print
    var uri = Uri.parse(url);
    var headers = createHeaders();

    var response = await http.post(uri,
        headers: headers, body: body != null ? jsonEncode(body) : null);
    print("Response status: ${response.statusCode}");
    print("Response body: ${response.body}");

    if (response.statusCode < 299) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 400) {
      try {
        final data = jsonDecode(response.body);
        throw ValidationException(data);
      } catch (_) {
        throw Exception('Bad Request');
      }
    } else if (response.statusCode == 401) {
      throw Exception("Unauthorized");
    } else {
      throw Exception("Something bad happened please try again");
    }
  }

  Future<dynamic> putToPath(String path, {Map<String, dynamic>? body}) async {
    var url = "$_baseUrl$path";

    print("Request URL: $url"); // Debug print
    var uri = Uri.parse(url);
    var headers = createHeaders();

    var response = await http.put(uri,
        headers: headers, body: body != null ? jsonEncode(body) : null);
    print("Response status: ${response.statusCode}");
    print("Response body: ${response.body}");

    if (response.statusCode < 299) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 400) {
      try {
        final data = jsonDecode(response.body);
        throw ValidationException(data);
      } catch (_) {
        throw Exception('Bad Request');
      }
    } else if (response.statusCode == 401) {
      throw Exception("Unauthorized");
    } else {
      throw Exception("Something bad happened please try again");
    }
  }

  bool isValidResponse(Response response) {
    if (response.statusCode < 299) {
      return true;
    } else if (response.statusCode == 401) {
      throw Exception("Unauthorized");
    } else {
      throw Exception("Something bad happened please try again");
    }
  }

  Map<String, String> createHeaders() {
    return Auth.createAuthHeaders();
  }
}
