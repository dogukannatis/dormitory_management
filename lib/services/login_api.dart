
import 'package:dormitory_management/models/users/admin.dart';
import 'package:dormitory_management/models/users/dormitory_owner.dart';
import 'package:dormitory_management/models/users/student.dart';
import 'package:flutter/cupertino.dart';

import '../models/users/user.dart';
import 'api.dart';

class LoginApi extends Api{


  Future<User?> login({required String email, required String password}) async {
    final response = await dio.get("$baseUrl/Login", queryParameters: {"email" : email, "Password": password}, options: options);
    debugPrint("response: $response");
    var data = response.data;
    switch(data["userType"]){
      case "student":
        return Student.fromJson(data);
      case "dormitoryOwner":
        return DormitoryOwner.fromJson(data);
      case "admin":
        return Admin.fromJson(data);
      default:
        return Student.fromJson(data);
    }
  }



}