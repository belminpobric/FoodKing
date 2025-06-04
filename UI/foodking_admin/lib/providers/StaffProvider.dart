import 'package:foodking_admin/providers/base_provider.dart';

class StaffProvider extends BaseProvider {
  StaffProvider() : super("Staff");

  Future<dynamic> getStaffs({String? searchString}) async {
    return super.get();
  }

  Future<dynamic> insertStaff(Map<String, dynamic> staff) async {
    return super.post(staff);
  }
}
