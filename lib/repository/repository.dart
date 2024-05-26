import 'package:dormitory_management/locator.dart';
import 'package:dormitory_management/models/dormitory.dart';
import 'package:dormitory_management/models/dormitory_details.dart';
import 'package:dormitory_management/models/users/student.dart';
import 'package:dormitory_management/models/users/user.dart';
import 'package:dormitory_management/services/dormitory_api.dart';
import 'package:dormitory_management/services/dormitory_details.dart';
import 'package:dormitory_management/services/login_api.dart';

import 'package:dormitory_management/services/student_api.dart';
import 'package:flutter/cupertino.dart';


class Repository {
  final _studentApi = locator<StudentApi>();
  final _dormitoryApi = locator<DormitoryApi>();
  final _dormitoryDetailsApi = locator<DormitoryDetailsApi>();
  final _loginApi = locator<LoginApi>();

  Future<void> saveStudent({required Student user}) async {
    await _studentApi.saveStudent(user: user);
  }

  Future<void> updateStudent({required Student user}) async {
    await _studentApi.updateStudent(user: user);
  }

  Future<List<Dormitory>> getAllDormitories() async {
    List<Dormitory> dorms = [];
    dorms = await _dormitoryApi.getAllDormitories();
    for(Dormitory dorm in dorms){
      dorm.dormitoryDetails = await _dormitoryDetailsApi.getDormitoryDetailsByDormitoryID(dormitoryId: dorm.dormitoryId!);
      debugPrint("details ${dorm.dormitoryDetails}");
    }
    return dorms;
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

  Future<void> getDormitoryDetailsByDormitoryID({required int dormitoryId}) async {
    await _dormitoryDetailsApi.getDormitoryDetailsByDormitoryID(dormitoryId: dormitoryId);
  }

  Future<User?> login({required String email, required String password}) async {
    return await _loginApi.login(email: email, password: password);
  }

}