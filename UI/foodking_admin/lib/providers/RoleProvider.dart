import 'package:foodking_admin/providers/base_provider.dart';

class RoleProvider extends BaseProvider {
  RoleProvider() : super("Role");

  Future<dynamic> getRoles() async {
    return super.get();
  }
}
