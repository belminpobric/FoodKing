import 'package:foodking_admin/providers/base_provider.dart';

class ProductProvider extends BaseProvider {
  ProductProvider() : super("Product");

  Future<dynamic> insertProduct(Map<String, dynamic> product) async {
    return super.post(product);
  }

  Future<dynamic> getProducts({int? menuId}) async {
    final queryParams = <String, dynamic>{};
    if (menuId != null) queryParams['Menu'] = menuId;
    return super.get(queryParams: queryParams.isNotEmpty ? queryParams : null);
  }
}
