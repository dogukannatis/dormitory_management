import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dormitory_management/models/app_notification.dart';
import 'package:dormitory_management/services/api.dart';
import 'package:flutter/material.dart';


class NotificationApi extends Api{


  /// Save notification to database with given [dormitory] object.
  /// PLEASE NOTE THAT: NOTIFICATION ID SHOULD BE NULL.
  /// Works properly
  Future<bool?> saveNotification({required AppNotification notification}) async {


    var data = jsonEncode(notification.toJson());
    debugPrint("notification: data: $data");

    try{
      final response = await dio.post("$baseUrl/Notification/add", data: data, options: options);
      debugPrint("response: $response");
      return true;
    } on DioException catch (e, str) {
       debugPrint("HATA: $e, $str");
       return false;
    }


  }

  Future<void> sendNotificationToAllDormStudents({required AppNotification appNotification}) async {
    var data = jsonEncode(appNotification.toJson());
    debugPrint("notification: data: $data");
    try{
      final response = await dio.post("$baseUrl/Notification/SendNotificationToAllByDormId", data: data, queryParameters: {"dormitoryId" : appNotification.senderId!} , options: options);
      debugPrint("response: $response");
    } on DioException catch (e, str) {
       debugPrint("HATA: $e, $str");
    }

  }



  /// Get notification with [id]
  /// Works properly
  Future<AppNotification?> getNotificationByID({required int notificationId}) async {
  
    try{
      final response = await dio.get("$baseUrl/Notification/getNotificationById", queryParameters: {"id" : notificationId}, options: options);
      debugPrint("response: $response");
      AppNotification notification = AppNotification.fromJson(response.data);
      debugPrint("notification: $notification");
      return notification;
    } on DioException catch (e, str) {
       debugPrint("HATA: $e, $str");
       return null;
    }

  }


  /// Get all user's notifications from database
  /// Works properly
  Future<List<AppNotification>> getAllNotificationsByStudentId({required int studentId}) async {
  
    try{
      final response = await dio.get("$baseUrl/Notification/getAllNotificationByStudentId",queryParameters: {"studentId" : studentId}, options: options);
      debugPrint("response: $response");
      List<AppNotification> notification = [];

      List? responseData = response.data;

      if(responseData != null && responseData.isNotEmpty){
        for(int i = 0; i < responseData.length; i++){
          notification.add(AppNotification.fromJson(responseData[i]));
        }
      }

      return notification;
    } on DioException catch (e, str) {
       debugPrint("HATA: $e, $str");
       return [];
    }

  }



  /// Delete notification with [notificationId]
  /// Works properly
  Future<bool?> deleteNotificationByID({required int notificationId}) async {
  
    try{
      final response = await dio.delete("$baseUrl/Notification/delete", queryParameters: {"id" : notificationId}, options: options);
      debugPrint("response: $response");
      return true;
    } on DioException catch (e, str) {
       debugPrint("HATA: $e, $str");
       return false;
    }

  }


  /// Update notification with [notification] object.
  /// Works properly
  Future<bool?> updateNotification({required AppNotification notification}) async {
  
    try{
      
      var data = notification.toJson();
      debugPrint("data: $data");
      final response = await dio.put("$baseUrl/Notification/update", queryParameters: data, options: options);
      debugPrint("response: $response");
      return true;
    } on DioException catch (e, str) {
       debugPrint("HATA: $e, $str");
       return false;
    }

  }


}