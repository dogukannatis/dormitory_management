import 'dart:convert';

import 'package:dio/dio.dart';
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


  Future<bool?> deleteRoom({required int roomId}) async {

debugPrint("dada: $roomId");
    try{
      final response = await dio.delete("$baseUrl/Room/delete", queryParameters: {"id" : roomId}, options: options);
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

  Future<List<Room>> getRoomByDormitoryId({required int dormitoryId}) async {

    try{
      final response = await dio.get("$baseUrl/Room/getRoomByDormitoryId", queryParameters: {"dormId" : dormitoryId}, options: options);
      debugPrint("response: $response");
      List<Room> rooms = [];

      List? responseData = response.data;

      if(responseData != null && responseData.isNotEmpty){
        for(int i = 0; i < responseData.length; i++){
          rooms.add(Room.fromJson(responseData[i]));
        }
      }
      return rooms;
    } on DioException catch (e, str) {
      debugPrint("HATA: $e, $str");
      return [];
    }

  }

  Future<Room?> getRoomById({required int roomId}) async {

    try{
      final response = await dio.get("$baseUrl/Room/getRoomById", queryParameters: {"id" : roomId}, options: options);
      debugPrint("response: $response");
      Room room = Room.fromJson(response.data);
      debugPrint("Room: $room");
      return room;
    } on DioException catch (e, str) {
      debugPrint("HATA: $e, $str");
      return null;
    }

  }


}