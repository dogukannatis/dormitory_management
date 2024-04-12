
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dormitory_management/models/users/student.dart';
import 'package:dormitory_management/models/users/user.dart';
import 'package:flutter/material.dart';

class Api {

  static String baseUrl = "https://localhost:7247/api";
  static String port = "0";

  static String adminUrl ="Admin";
  static String userUrl ="User";
 
 Options _options = Options(contentType: Headers.jsonContentType, headers: {"accept" : "*/*"});

  final dio = Dio();

  Future<User?> login({required String email, required String password}) async {
    final response = await dio.get("$baseUrl/Login");
      debugPrint("response: $response");
  }


  /// Save student to database with given [user] object
  /// Works properly
  Future<bool?> saveStudent({required Student user}) async {
    

    var data = jsonEncode(user.toJson());
    debugPrint("saveStudent: data: $data");
    
    try{
      final response = await dio.post("$baseUrl/Student/add", data: data, options: _options);
      debugPrint("response: $response");
      return true;
    } on DioException catch (e, str) {
       debugPrint("HATA: $e, $str");
       return false;
    }

    
  }


  /// Get user with [id]
  /// Works properly
  Future<Student?> getStudentByID({required int id}) async {
  
    try{
      final response = await dio.get("$baseUrl/Student/getStudentById", queryParameters: {"id" : id}, options: _options);
      debugPrint("response: $response");
      Student _student = Student.fromJson(response.data);
      debugPrint("_student: $_student");
      return _student;
    } on DioException catch (e, str) {
       debugPrint("HATA: $e, $str");
       return null;
    }

  }

  /// Delete user with [id]
  /// Not checked
  Future<bool?> deleteStudentByID({required int id}) async {
  
    try{
      final response = await dio.get("$baseUrl/Student/delete", queryParameters: {"id" : id}, options: _options);
      debugPrint("response: $response");
      return true;
    } on DioException catch (e, str) {
       debugPrint("HATA: $e, $str");
       return false;
    }

  }

  /// Get all students from database.
  /// Returns empty list if any error occured.
  /// Workks properly
  Future<List<Student>> getAllStudents() async {
  
    try{
      final response = await dio.get("$baseUrl/Student/getAll", options: _options);
      debugPrint("response: $response");
      List<Student> _students = [];

      List? _responseData = response.data;

      if(_responseData != null && _responseData.isNotEmpty){
        for(int i = 0; i < _responseData.length; i++){
          _students.add(Student.fromJson(_responseData[i]));
        }
      }
      debugPrint("_students: $_students");
      return _students;
    } on DioException catch (e, str) {
       debugPrint("HATA: $e, $str");
       return [];
    }

  }


  /// Update user with [student] object.
  /// Not checked
  Future<bool?> updateStudent({required Student user}) async {
  
    try{
       debugPrint("datas: ${user.toJson()}");
      var data = user.toJson();
      
      debugPrint("data: $data");
      final response = await dio.get("$baseUrl/Student/update", queryParameters: data, options: _options);
      debugPrint("response: $response");
      return true;
    } on DioException catch (e, str) {
       debugPrint("HATA: $e, $str");
       return false;
    }

  }






  Future<void> getAllAdmins({required String token}) async {

    try{
      final response = await dio.get("$adminUrl/add");
      debugPrint("response: $response");

      if(response.statusCode == 200){
        debugPrint("Data: ${response.data}");

        // User user = User.fromMap(response.data);
        // user.token = token;

        // debugPrint(user.toString());
        // return user;

      }else{
        debugPrint("Hata: ${response.statusCode} ${response.statusMessage}");
        throw "response code: ${response.statusCode}";
      }


    } on DioException catch(e, str){
      debugPrint("HATA: $e $str");
      debugPrint(e.response.toString());
      debugPrint(e.message);
    }




  }


/*
{
  "userId": 0,
  "studentNumber": "4000",
  "department": "string",
  "gender": "string",
  "emergencyContactNo": "string",
  "name": "saner",
  "surName": "at",
  "email": "eren222@hotmail.com",
  "password": "string",
  "address": "string",
  "phoneNo": "string",
  "isEmailVerified": true,
  "createdAt": "2024-04-12T20:06:15.175Z",
  "updatedAt": "2024-04-12T20:06:15.175Z",
  "dob": "2024-04-12T20:06:15.175Z",
  "profileUrl": "string"
}
*/




}