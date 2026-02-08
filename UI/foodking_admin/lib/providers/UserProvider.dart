import 'package:foodking_admin/providers/base_provider.dart';

class UserProvider extends BaseProvider {
  UserProvider() : super("User");

  Future<dynamic> getUsers(
      {String? searchString, isRoleIncluded = false}) async {
    final Map<String, dynamic> queryParams = {};
    if (searchString != null && searchString.isNotEmpty) {
      queryParams['searchString'] = searchString;
    }
    queryParams['isRoleIncluded'] = isRoleIncluded;
    return super.get(queryParams: queryParams);
  }

  Future<dynamic> insertUser(Map<String, dynamic> User) async {
    return super.post(User);
  }
}
