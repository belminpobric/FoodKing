import 'package:foodking_admin/providers/base_provider.dart';

class UserProvider extends BaseProvider {
  UserProvider() : super("User");

  Future<dynamic> getUsers({String? searchString}) async {
    return super.get();
  }

  Future<dynamic> insertUser(Map<String, dynamic> User) async {
    return super.post(User);
  }
}
