import 'package:foodking_admin/providers/base_provider.dart';

class MenuProvider extends BaseProvider {
  MenuProvider() : super("Menu");

  Future<dynamic> getMenus({String? searchString}) async {
    return super.get();
  }

  Future<dynamic> insertMenu(Map<String, dynamic> menu) async {
    return super.post(menu);
  }
}
