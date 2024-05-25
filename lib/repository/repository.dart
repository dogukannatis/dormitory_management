import 'package:dormitory_management/locator.dart';
import 'package:dormitory_management/models/dormitory.dart';
import 'package:dormitory_management/models/users/student.dart';
import 'package:dormitory_management/services/dormitory_api.dart';

import 'package:dormitory_management/services/student_api.dart';


class Repository {
  final _studentApi = locator<StudentApi>();
  final _dormitoryApi = locator<DormitoryApi>();



  Future<void> saveStudent({required Student user}) async {
    await _studentApi.saveStudent(user: user);
  }

  Future<List<Dormitory>> getAllDormitories() async {
    return await _dormitoryApi.getAllDormitories();
  }

  Future<void> saveDormitory({required Dormitory dormitory}) async {
    await _dormitoryApi.saveDormitory(dormitory: dormitory);
  }

  Future<void> updateDormitory({required Dormitory dormitory}) async {
    await _dormitoryApi.updateDormitory(dormitory: dormitory);
  }

   Future<void> deleteDormitoryByID({required int dormitoryId}) async {
    await _dormitoryApi.deleteDormitoryByID(dormitoryId: dormitoryId);
  }


}