import 'package:foodking_admin/providers/base_provider.dart';

class DailyMenuProvider extends BaseProvider {
  DailyMenuProvider() : super("DailyMenu");

  Future<dynamic> getDailyMenus({String? searchString}) async {
    return super.get();
  }

  Future<dynamic> insertDailyMenu(Map<String, dynamic> menu) async {
    return super.post(menu);
  }
}
