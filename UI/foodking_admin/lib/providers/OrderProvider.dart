import 'dart:convert';
import 'package:foodking_admin/utils/util.dart';
import 'package:http/http.dart';
import 'package:foodking_admin/providers/base_provider.dart';

class OrderProvider extends BaseProvider {
  OrderProvider() : super("Order");

  Future<dynamic> getOrders({bool? isAccepted, int? idGTE}) async {
    final queryParams = <String, dynamic>{};

    if (isAccepted != null) {
      queryParams['IsAccepted'] = isAccepted.toString().toLowerCase();
    }

    if (idGTE != null) {
      queryParams['IdGTE'] = idGTE.toString();
    }

    return super.get(queryParams: queryParams);
  }

  @override
  bool isValidResponse(Response response) {
    if (response.statusCode < 299) {
      return true;
    } else if (response.statusCode == 401) {
      throw Exception("Unauthorized");
    } else {
      throw Exception("Something bad happened please try again");
    }
  }

  @override
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
