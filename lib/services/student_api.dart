
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dormitory_management/models/app_notification.dart';
import 'package:dormitory_management/models/users/student.dart';
import 'package:dormitory_management/services/api.dart';
import 'package:flutter/material.dart';

class StudentApi extends Api{

  /// Save student to database with given [user] object.
  /// PLEASE NOTE THAT: USER ID SHOULD BE NULL.
  /// Works properly
  Future<bool?> saveStudent({required Student user}) async {
    

    var data = jsonEncode(user.toJson());
    debugPrint("saveStudent: data: $data");
    
    try{
      final response = await dio.post("$baseUrl/Student/add", data: data, options: options);
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
      final response = await dio.get("$baseUrl/Student/getStudentById", queryParameters: {"id" : id}, options: options);
      debugPrint("response: $response");
      Student _student = Student.fromJson(response.data);
      debugPrint("_student: $_student");
      return _student;
    } on DioException catch (e, str) {
       debugPrint("HATA: $e, $str");
       return null;
    }

  }

  /// Get user with [name]
  /// If threre is more than one user, it crashed. 
  /// Backend should be fixed.
  Future<Student?> getStudentByName({required String name}) async {
  
    try{
      final response = await dio.get("$baseUrl/Student/getStudentByName", queryParameters: {"name" : name}, options: options);
      debugPrint("response: $response");
      Student _student = Student.fromJson(response.data);
      debugPrint("_student: $_student");
      return _student;
    } on DioException catch (e, str) {
       debugPrint("HATA: $e, $str");
       return null;
    }

  }


  /// Get user profile info with user's [id]
  /// Works properly
  Future<Student?> viewStudentProfileInfo({required int id}) async {
  
    try{
      final response = await dio.get("$baseUrl/Student/vievStudentProfileInfo", queryParameters: {"id" : id}, options: options);
      debugPrint("response: $response");
      Student _student = Student.fromJson(response.data);
      debugPrint("_student: $_student");
      return _student;
    } on DioException catch (e, str) {
       debugPrint("HATA: $e, $str");
       return null;
    }

  }


  /// Get user's notifications with [id]
  /// Not ready for use.
  @Deprecated("Not ready for use")
  Future<List<AppNotification>> getNotificationByStudentId({required int id}) async {
  
    try{
      final response = await dio.get("$baseUrl/Student/GetNotificationByStudentId", queryParameters: {"id" : id}, options: options);
      debugPrint("response: $response");
      List<AppNotification> _notifications = [];

      List? _responseData = response.data;

      if(_responseData != null && _responseData.isNotEmpty){
        for(int i = 0; i < _responseData.length; i++){
          _notifications.add(AppNotification.fromJson(_responseData[i]));
        }
      }
      
      
      debugPrint("_notifications: $_notifications");
      return _notifications;
    } on DioException catch (e, str) {
       debugPrint("HATA: $e, $str");
       return [];
    }

  }



  /// Delete user with [id]
  /// Not checked
  Future<bool?> deleteStudentByID({required int id}) async {
  
    try{
      final response = await dio.delete("$baseUrl/Student/delete", queryParameters: {"id" : id}, options: options);
      debugPrint("response: $response");
      return true;
    } on DioException catch (e, str) {
       debugPrint("HATA: $e, $str");
       return false;
    }

  }

  /// Get all students from database.
  /// Returns empty list if any error occured.
  /// Works properly
  Future<List<Student>> getAllStudents() async {
  
    try{
      final response = await dio.get("$baseUrl/Student/getAll", options: options);
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
  /// Works properly
  Future<bool?> updateStudent({required Student user}) async {
  
    try{
      
      var data = user.toJson();
      debugPrint("data: $data");
      final response = await dio.put("$baseUrl/Student/update", queryParameters: data, options: options);
      debugPrint("response: $response");
      return true;
    } on DioException catch (e, str) {
       debugPrint("HATA: $e, $str");
       return false;
    }

  }
  
}