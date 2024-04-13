

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dormitory_management/models/users/admin.dart';
import 'package:dormitory_management/services/api.dart';
import 'package:flutter/material.dart';

class AdminApi extends Api{


  /// Get all admin users from database.
  /// Returns empty list if any error occured.
  /// Works properly
  Future<List<Admin>> getAllAdmins() async {
  
    try{
      final response = await dio.get("$baseUrl/Admin/getAll", options: options);
      debugPrint("response: $response");
      List<Admin> _admins = [];

      List? _responseData = response.data;

      if(_responseData != null && _responseData.isNotEmpty){
        for(int i = 0; i < _responseData.length; i++){
          _admins.add(Admin.fromJson(_responseData[i]));
        }
      }
      debugPrint("_admins: $_admins");
      return _admins;
    } on DioException catch (e, str) {
       debugPrint("HATA: $e, $str");
       return [];
    }

  }


  /// Save admin to database with given [user] object.
  /// PLEASE NOTE THAT: USER ID SHOULD BE NULL.
  /// Has error. Backend should be fixed
  Future<bool?> saveAdmin({required Admin user}) async {
    

    var data = jsonEncode(user.toJson());
    
    debugPrint("saveAdmin: data: $data");
    
    try{
      final response = await dio.post("$baseUrl/Admin/add", data: data, options: options);
      debugPrint("response: $response");
      return true;
    } on DioException catch (e, str) {
       debugPrint("HATA: $e, $str");
       return false;
    }

    
  }


  /// Delete admin from database with given [user] object.
  /// 
  Future<bool?> deleteAdmin({required int id}) async {

    
    try{
      final response = await dio.delete("$baseUrl/Admin/delete", queryParameters: {"id": id}, options: options);
      debugPrint("response: $response");
      return true;
    } on DioException catch (e, str) {
       debugPrint("HATA: $e, $str");
       return false;
    }

    
  }



  /// Update admin with [user] object.
  /// 
  Future<bool?> updateAdmin({required Admin user}) async {
  
    try{
      
      var data = user.toJson();
      debugPrint("data: $data");
      final response = await dio.put("$baseUrl/Admin/update", queryParameters: data, options: options);
      debugPrint("response: $response");
      return true;
    } on DioException catch (e, str) {
       debugPrint("HATA: $e, $str");
       return false;
    }

  }


  /// Get admin with [id]
  /// Works properly
  Future<Admin?> getAdminByID({required int id}) async {
  
    try{
      final response = await dio.get("$baseUrl/Admin/getAdminById", queryParameters: {"id" : id}, options: options);
      debugPrint("response: $response");
      Admin admin = Admin.fromJson(response.data);
      debugPrint("_admin: $admin");
      return admin;
    } on DioException catch (e, str) {
       debugPrint("HATA: $e, $str");
       return null;
    }

  }

 

}