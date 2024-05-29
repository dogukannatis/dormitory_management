import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dormitory_management/models/dormitory_details.dart';
import 'package:dormitory_management/services/api.dart';
import 'package:flutter/material.dart';


class DormitoryDetailsApi extends Api{


  /// Save dormitory details to database with given [dormitoryDetails] object.
  /// PLEASE NOTE THAT: DORMITORY DETAILS ID SHOULD BE NULL.
  /// Works properly
  Future<bool?> saveDormitoryDetails({required DormitoryDetails dormitoryDetails}) async {
    

    var data = jsonEncode(dormitoryDetails.toJson());
    debugPrint("saveDormitoryDetails: data: $data");
    
    try{
      final response = await dio.post("$baseUrl/DormitoryDetail/add", data: data, options: options);
      debugPrint("response: $response");
      return true;
    } on DioException catch (e, str) {
       debugPrint("HATA: $e, $str");
       return false;
    }

    
  }



  /// Get dormitory details with [dormitoryDetailsId]
  /// Works properly
  Future<DormitoryDetails?> getDormitoryDetailsByID({required int dormitoryDetailsId}) async {
  
    try{
      final response = await dio.get("$baseUrl/DormitoryDetail/getDormitoryDetailById", queryParameters: {"id" : dormitoryDetailsId}, options: options);
      debugPrint("response: $response");
      DormitoryDetails dormitoryDetails = DormitoryDetails.fromJson(response.data);
      debugPrint("dormitoryDetails: $dormitoryDetails");
      return dormitoryDetails;
    } on DioException catch (e, str) {
       debugPrint("HATA: $e, $str");
       return null;
    }

  }

  /// Get dormitory details with [dormitoryDetailsId]
  /// Works properly
  Future<DormitoryDetails?> getDormitoryDetailsByDormitoryID({required int dormitoryId}) async {

    try{
      final response = await dio.get("$baseUrl/DormitoryDetail/getDormitoryDetailByDormitoryId", queryParameters: {"id" : dormitoryId}, options: options);
      debugPrint("response: $response");
      DormitoryDetails dormitoryDetails = DormitoryDetails.fromJson(response.data);
      debugPrint("dormitoryDetails: $dormitoryDetails");
      return dormitoryDetails;
    } on DioException catch (e, str) {
       debugPrint("HATA: $e, $str");
       return null;
    }

  }





  /// Delete dormitory details with [dormitoryDetailsId]
  /// Works properly
  Future<bool?> deleteDormitoryDetailsByID({required int dormitoryDetailsId}) async {
  
    try{
      final response = await dio.delete("$baseUrl/DormitoryDetail/delete", queryParameters: {"id" : dormitoryDetailsId}, options: options);
      debugPrint("response: $response");
      return true;
    } on DioException catch (e, str) {
       debugPrint("HATA: $e, $str");
       return false;
    }

  }


  /// Update dormitory details with [dormitoryDetails] object.
  /// ERROR: check again with backend team
  Future<bool?> updateDormitoryDetails({required DormitoryDetails dormitoryDetails}) async {
  
    try{
      
      var data = dormitoryDetails.toJson();
      debugPrint("data: $data");
      final response = await dio.put("$baseUrl/DormitoryDetail/update", queryParameters: data, options: options);
      debugPrint("response: $response");
      return true;
    } on DioException catch (e, str) {
       debugPrint("HATA: $e, $str");
       return false;
    }

  }


}