import 'package:dormitory_management/locator.dart';
import 'package:dormitory_management/models/users/student.dart';

import 'package:dormitory_management/services/student_api.dart';

class UserRepository {
  final _studentApi = locator<StudentApi>();



  Future<void> saveStudent({required Student user}) async {
    await _studentApi.saveStudent(user: user);
  }


}