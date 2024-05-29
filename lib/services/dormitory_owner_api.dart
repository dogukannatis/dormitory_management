

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dormitory_management/models/booking.dart';
import 'package:dormitory_management/models/users/admin.dart';
import 'package:dormitory_management/models/users/dormitory_owner.dart';
import 'package:dormitory_management/services/api.dart';
import 'package:flutter/material.dart';

class DormitoryOwnerApi extends Api{


  Future<Booking?> getApprovedBookingByUserId({required int userId}) async {

    try{
      final response = await dio.get("$baseUrl/DormitoryOwner/getApprovedBookingByUserId", queryParameters: {"id" : userId}, options: options);
      debugPrint("response: $response");
      Booking booking = Booking.fromJson(response.data);
      debugPrint("comment: $booking");
      return booking;
    } on DioException catch (e, str) {
      debugPrint("HATA: $e, $str");
      return null;
    }

  }

  /// Get all dormitory owners from database.
  /// Returns empty list if any error occured.
  /// Works properly
  Future<List<DormitoryOwner>> getAllDormitoryOwners() async {
  
    try{
      final response = await dio.get("$baseUrl/DormitoryOwner/getAll", options: options);
      debugPrint("response: $response");
      List<DormitoryOwner> dormitoryOwners = [];

      List? _responseData = response.data;

      if(_responseData != null && _responseData.isNotEmpty){
        for(int i = 0; i < _responseData.length; i++){
          dormitoryOwners.add(DormitoryOwner.fromJson(_responseData[i]));
        }
      }
      debugPrint("dormitoryOwners: $dormitoryOwners");
      return dormitoryOwners;
    } on DioException catch (e, str) {
       debugPrint("HATA: $e, $str");
       return [];
    }

  }


  /// Save dormitory owner to database with given [user] object.
  /// PLEASE NOTE THAT: USER ID SHOULD BE NULL.
  /// Has error. Backend should be fixed
  Future<bool?> saveDormitoryOwner({required DormitoryOwner user}) async {
    

    var data = jsonEncode(user.toJson());
    
    debugPrint("saveDormitoryOwner: data: $data");
    
    try{
      final response = await dio.post("$baseUrl/DormitoryOwner/add", data: data, options: options);
      debugPrint("response: $response");
      return true;
    } on DioException catch (e, str) {
       debugPrint("HATA: $e, $str");
       return false;
    }

    
  }


  /// Delete dormitory owner from database with given id.
  /// 
  Future<bool?> deleteDormitoryOwnerByID({required int id}) async {

    
    try{
      final response = await dio.delete("$baseUrl/DormitoryOwner/delete", queryParameters: {"id": id}, options: options);
      debugPrint("response: $response");
      return true;
    } on DioException catch (e, str) {
       debugPrint("HATA: $e, $str");
       return false;
    }

    
  }



  /// Update dormitory owner with [user] object.
  /// 
  Future<bool?> updateDormitoryOwner({required DormitoryOwner user}) async {
  
    try{
      
      var data = user.toJson();
      debugPrint("data: $data");
      final response = await dio.put("$baseUrl/DormitoryOwner/update", queryParameters: data, options: options);
      debugPrint("response: $response");
      return true;
    } on DioException catch (e, str) {
       debugPrint("HATA: $e, $str");
       return false;
    }

  }


  /// Get dormitory owner with [id]
  /// Works properly
  Future<DormitoryOwner?> getDormitoryOwnerByID({required int id}) async {
  
    try{
      final response = await dio.get("$baseUrl/DormitoryOwner/getDormitoryOwner", queryParameters: {"id" : id}, options: options);
      debugPrint("response: $response");
      DormitoryOwner dormitoryOwner = DormitoryOwner.fromJson(response.data);
      debugPrint("dormitoryOwner: $dormitoryOwner");
      return dormitoryOwner;
    } on DioException catch (e, str) {
       debugPrint("HATA: $e, $str");
       return null;
    }

  }

 


  /// Get all pending bookings for dormitory from database.
  /// Returns empty list if any error occured.
  /// Works properly
  Future<List<Booking>> getPendingBookingsForDormitory({required int dormId}) async {
  
    try{
      final response = await dio.get("$baseUrl/DormitoryOwner/GetPendingBookingsForSpecificDormitory",  queryParameters: {"dormId" : dormId}, options: options);
      debugPrint("response: $response");
      List<Booking> bookings = [];

      List? _responseData = response.data;

      if(_responseData != null && _responseData.isNotEmpty){
        for(int i = 0; i < _responseData.length; i++){
          bookings.add(Booking.fromJson(_responseData[i]));
        }
      }
      debugPrint("bookings: $bookings");
      return bookings;
    } on DioException catch (e, str) {
       debugPrint("HATA: $e, $str");
       return [];
    }

  }


  /// Get all bookings for dormitory from database.
  /// Returns empty list if any error occured.
  /// Works properly
  Future<List<Booking>> getallBookingsForDormitory({required int dormId}) async {
  
    try{
      final response = await dio.get("$baseUrl/DormitoryOwner/GetAllBookingsForSpecificDormitory", queryParameters: {"dormId" : dormId},  options: options);
      debugPrint("response: $response");
      List<Booking> bookings = [];

      List? _responseData = response.data;

      if(_responseData != null && _responseData.isNotEmpty){
        for(int i = 0; i < _responseData.length; i++){
          bookings.add(Booking.fromJson(_responseData[i]));
        }
      }
      debugPrint("bookings: $bookings");
      return bookings;
    } on DioException catch (e, str) {
       debugPrint("HATA: $e, $str");
       return [];
    }

  }


  /// Approve student's booking request with userId
  /// !!!Should be impelemented!!!
  Future<bool?> approveStudentsBookingRequest({required int bookingId}) async {
  
    return false;

  }



}