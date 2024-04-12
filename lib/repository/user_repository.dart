import 'package:dormitory_management/locator.dart';
import 'package:dormitory_management/models/users/student.dart';

import 'package:dormitory_management/services/api.dart';

class UserRepository {
  final _api = locator<Api>();



  Future<void> saveStudent({required Student user}) async {
    await _api.saveStudent(user: user);
  }


}