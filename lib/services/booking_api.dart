import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dormitory_management/models/booking.dart';
import 'package:dormitory_management/services/api.dart';
import 'package:flutter/material.dart';


class BookingApi extends Api{


  /// Save booking to database with given [booking] object.
  /// PLEASE NOTE THAT: BOOKING ID SHOULD BE NULL.
  /// Works properly
  Future<bool?> saveBooking({required Booking booking}) async {
    

    var data = jsonEncode(booking.toJson());
    debugPrint("saveStudent: data: $data");
    
    try{
      final response = await dio.post("$baseUrl/Booking/add", data: data, options: options);
      debugPrint("response: $response");
      return true;
    } on DioException catch (e, str) {
       debugPrint("HATA: $e, $str");
       return false;
    }

    
  }



  /// Get booking with [id]
  /// Works properly
  Future<Booking?> getBookingByID({required int id}) async {
  
    try{
      final response = await dio.get("$baseUrl/Booking/getBookingById", queryParameters: {"id" : id}, options: options);
      debugPrint("response: $response");
      Booking booking = Booking.fromJson(response.data);
      debugPrint("booking: $booking");
      return booking;
    } on DioException catch (e, str) {
       debugPrint("HATA: $e, $str");
       return null;
    }

  }

  /// Get user's booking history with [userId]
  /// Works properly
  Future<List<Booking>> getBookingHistoryByStudentId({required int userId}) async {
  
    try{
      final response = await dio.get("$baseUrl/Booking/GetBookingHistoryByStudentId", queryParameters: {"studentId" : userId}, options: options);
      debugPrint("response: $response");
      List<Booking> bookingList = [];

      List? responseData = response.data;

      if(responseData != null && responseData.isNotEmpty){
        for(int i = 0; i < responseData.length; i++){
          bookingList.add(Booking.fromJson(responseData[i]));
        }
      }

      return bookingList;
    } on DioException catch (e, str) {
       debugPrint("HATA: $e, $str");
       return [];
    }

  }


  /// Get all bookings from database
  /// Works properly
  Future<List<Booking>> getAllBookings() async {
  
    try{
      final response = await dio.get("$baseUrl/Booking/getAll", options: options);
      debugPrint("response: $response");
      List<Booking> bookingList = [];

      List? responseData = response.data;

      if(responseData != null && responseData.isNotEmpty){
        for(int i = 0; i < responseData.length; i++){
          bookingList.add(Booking.fromJson(responseData[i]));
        }
      }

      return bookingList;
    } on DioException catch (e, str) {
       debugPrint("HATA: $e, $str");
       return [];
    }

  }

  Future<List<Booking>> getBookingsByDormitoryId({required int dormitoryId}) async {

    try{
      final response = await dio.get("$baseUrl/Booking/getBookingsByDormitoryId", queryParameters: {"dormitoryId" : dormitoryId}, options: options);
      debugPrint("response: $response");
      List<Booking> bookingList = [];

      List? responseData = response.data;

      if(responseData != null && responseData.isNotEmpty){
        for(int i = 0; i < responseData.length; i++){
          bookingList.add(Booking.fromJson(responseData[i]));
        }
      }

      return bookingList;
    } on DioException catch (e, str) {
       debugPrint("HATA: $e, $str");
       return [];
    }

  }



  /// Delete booking with [bookingId]
  /// Works properly
  Future<bool?> deleteStudentByID({required int bookingId}) async {
  
    try{
      final response = await dio.delete("$baseUrl/Booking/delete", queryParameters: {"id" : bookingId}, options: options);
      debugPrint("response: $response");
      return true;
    } on DioException catch (e, str) {
       debugPrint("HATA: $e, $str");
       return false;
    }

  }


  /// Update booking with [booking] object.
  /// Works properly
  Future<bool?> updateBooking({required Booking booking}) async {
  
    try{
      
      var data = booking.toJson();
      debugPrint("data: $data");
      final response = await dio.put("$baseUrl/Booking/update", queryParameters: data, options: options);
      debugPrint("response: $response");
      return true;
    } on DioException catch (e, str) {
       debugPrint("HATA: $e, $str");
       return false;
    }

  }


}