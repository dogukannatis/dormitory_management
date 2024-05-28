import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dormitory_management/models/booking.dart';
import 'package:dormitory_management/models/room.dart';
import 'package:dormitory_management/services/api.dart';
import 'package:flutter/material.dart';


class RoomApi extends Api{


  /// Save booking to database with given [booking] object.
  /// PLEASE NOTE THAT: BOOKING ID SHOULD BE NULL.
  /// Works properly
  Future<bool?> saveRoom({required Room room}) async {


    var data = jsonEncode(room.toJson());

    try{
      final response = await dio.post("$baseUrl/Room/add", data: data, options: options);
      debugPrint("response: $response");
      return true;
    } on DioException catch (e, str) {
      debugPrint("HATA: $e, $str");
      return false;
    }


  }



  /// Update booking with [booking] object.
  /// Works properly
  Future<bool?> updateRoom({required Room room}) async {

    try{

      var data = room.toJson();
      debugPrint("data: $data");
      final response = await dio.put("$baseUrl/Room/update", queryParameters: data, options: options);
      debugPrint("response: $response");
      return true;
    } on DioException catch (e, str) {
      debugPrint("HATA: $e, $str");
      return false;
    }

  }


}