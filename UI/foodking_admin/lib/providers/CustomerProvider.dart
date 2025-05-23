import 'package:foodking_admin/providers/base_provider.dart';

class CustomerProvider extends BaseProvider {
  CustomerProvider() : super("Customer");

  Future<dynamic> getCustomers({String? searchString}) async {
    final queryParams = <String, dynamic>{};

    if (searchString != null && searchString.isNotEmpty) {
      queryParams['NameGTE'] = searchString;
    }

    return super.get(queryParams: queryParams);
  }
}
