import 'dart:convert';
import 'package:foodking_admin/utils/util.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:http/http.dart';

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
    print("Response status: ${response.statusCode}"); // Debug print
    print("Response body: ${response.body}"); // Debug print

    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception("Unknown error");
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
    String username = Authorization.username ?? "";
    String password = Authorization.password ?? "";

    print("$username, $password");
    String basicAuth =
        "Basic ${base64Encode(utf8.encode('$username:$password'))}";

    var headers = {
      "Content-Type": "application/json",
      "Accept": "text/plain",
      "Authorization": basicAuth,
    };

    print("HEADERS → $headers");
    return headers;
  }
}
