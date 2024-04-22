import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dormitory_management/models/app_notification.dart';
import 'package:dormitory_management/models/rating.dart';
import 'package:dormitory_management/services/api.dart';
import 'package:flutter/material.dart';


class RatingApi extends Api{


  /// Save rating to database with given [rating] object.
  /// PLEASE NOTE THAT: RATING ID SHOULD BE NULL.
  /// Works properly
  Future<bool?> saveRating({required Rating rating}) async {
    

    var data = jsonEncode(rating.toJson());
    debugPrint("rating: data: $data");
    
    try{
      final response = await dio.post("$baseUrl/Rating/add", data: data, options: options);
      debugPrint("response: $response");
      return true;
    } on DioException catch (e, str) {
       debugPrint("HATA: $e, $str");
       return false;
    }

    
  }



  /// Get rating with [ratingId]
  /// Works properly
  Future<Rating?> getRatingByID({required int ratingId}) async {
  
    try{
      final response = await dio.get("$baseUrl/Rating/getRatingById", queryParameters: {"id" : ratingId}, options: options);
      debugPrint("response: $response");
      Rating rating = Rating.fromJson(response.data);
      debugPrint("rating: $rating");
      return rating;
    } on DioException catch (e, str) {
       debugPrint("HATA: $e, $str");
       return null;
    }

  }



  /// Delete rating with [ratingId]
  /// Works properly
  Future<bool?> deleteRatingByID({required int ratingId}) async {
  
    try{
      final response = await dio.delete("$baseUrl/Rating/delete", queryParameters: {"id" : ratingId}, options: options);
      debugPrint("response: $response");
      return true;
    } on DioException catch (e, str) {
       debugPrint("HATA: $e, $str");
       return false;
    }

  }


  /// Update rating with [rating] object.
  /// Works properly
  Future<bool?> updateRating({required Rating rating}) async {
  
    try{
      
      var data = rating.toJson();
      debugPrint("data: $data");
      final response = await dio.put("$baseUrl/Rating/update", queryParameters: data, options: options);
      debugPrint("response: $response");
      return true;
    } on DioException catch (e, str) {
       debugPrint("HATA: $e, $str");
       return false;
    }

  }


}