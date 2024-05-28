import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dormitory_management/models/dormitory.dart';
import 'package:dormitory_management/services/api.dart';
import 'package:flutter/material.dart';


class DormitoryApi extends Api{


  /// Save dormitory to database with given [dormitory] object.
  /// PLEASE NOTE THAT: DORMITORY ID SHOULD BE NULL.
  /// Works properly
  Future<Dormitory?> saveDormitory({required Dormitory dormitory}) async {
    

    var data = jsonEncode(dormitory.toJson());
    debugPrint("saveDormitory: data: $data");
    
    try{
      final response = await dio.post("$baseUrl/Dormitory/add", data: data, options: options);
      debugPrint("response: $response");
      Dormitory dormitory = Dormitory.fromJson(response.data);
      debugPrint("dormitory: $dormitory");
      return dormitory;
    } on DioException catch (e, str) {
       debugPrint("HATA: $e, $str");
       return null;
    }

    
  }



  /// Get dormitory with [id]
  /// Works properly
  Future<Dormitory?> getDormitoryByID({required int dormitoryId}) async {
  
    try{
      final response = await dio.get("$baseUrl/Dormitory/getDormitoryById", queryParameters: {"id" : dormitoryId}, options: options);
      debugPrint("response: $response");
      Dormitory dormitory = Dormitory.fromJson(response.data);
      debugPrint("dormitory: $dormitory");
      return dormitory;
    } on DioException catch (e, str) {
       debugPrint("HATA: $e, $str");
       return null;
    }

  }


  /// Get all dormitories from database
  /// Works properly
  Future<List<Dormitory>> getAllDormitories() async {
  
    try{
      final response = await dio.get("$baseUrl/Dormitory/getAll", options: options);
      debugPrint("response: $response");
      List<Dormitory> dormitories = [];

      List? responseData = response.data;

      if(responseData != null && responseData.isNotEmpty){
        for(int i = 0; i < responseData.length; i++){
          dormitories.add(Dormitory.fromJson(responseData[i]));
        }
      }

      return dormitories;
    } on DioException catch (e, str) {
       debugPrint("HATA: $e, $str");
       return [];
    }

  }



  /// Delete dormitory with [dormitoryId]
  /// Works properly
  Future<bool?> deleteDormitoryByID({required int dormitoryId}) async {
  
    try{
      final response = await dio.delete("$baseUrl/Dormitory/delete", queryParameters: {"id" : dormitoryId}, options: options);
      debugPrint("response: $response");
      return true;
    } on DioException catch (e, str) {
       debugPrint("HATA: $e, $str");
       return false;
    }

  }


  /// Update dormitory with [dormitory] object.
  /// Works properly
  Future<bool?> updateDormitory({required Dormitory dormitory}) async {
  
    try{
      
      var data = dormitory.toJson();
      debugPrint("data: $data");
      final response = await dio.put("$baseUrl/Dormitory/update", queryParameters: data, options: options);
      debugPrint("response: $response");
      return true;
    } on DioException catch (e, str) {
       debugPrint("HATA: $e, $str");
       return false;
    }

  }


}