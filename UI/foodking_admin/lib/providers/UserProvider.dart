import 'package:foodking_admin/providers/base_provider.dart';

class UserProvider extends BaseProvider {
  UserProvider() : super("User");

  Future<dynamic> getUsers({String? UserName, isRoleIncluded = false}) async {
    final Map<String, dynamic> queryParams = {};
    if (UserName != null && UserName.isNotEmpty) {
      queryParams['UserName'] = UserName;
    }
    queryParams['isRoleIncluded'] = isRoleIncluded;
    return super.get(queryParams: queryParams);
  }

  Future<dynamic> insertUser(Map<String, dynamic> User) async {
    return super.post(User);
  }
}
