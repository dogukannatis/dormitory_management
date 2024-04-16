import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dormitory_management/models/comment.dart';
import 'package:dormitory_management/services/api.dart';
import 'package:flutter/material.dart';


class CommentApi extends Api{


  /// Save comment to database with given [comment] object.
  /// PLEASE NOTE THAT: COMMENT ID SHOULD BE NULL.
  /// Works properly
  Future<bool?> saveComment({required Comment comment}) async {
    

    var data = jsonEncode(comment.toJson());
    debugPrint("saveComment: data: $data");
    
    try{
      final response = await dio.post("$baseUrl/Comment/add", data: data, options: options);
      debugPrint("response: $response");
      return true;
    } on DioException catch (e, str) {
       debugPrint("HATA: $e, $str");
       return false;
    }

    
  }



  /// Get comment with [id]
  /// Works properly
  Future<Comment?> getCommentByID({required int commentId}) async {
  
    try{
      final response = await dio.get("$baseUrl/Comment/getCommentById", queryParameters: {"id" : commentId}, options: options);
      debugPrint("response: $response");
      Comment comment = Comment.fromJson(response.data);
      debugPrint("comment: $comment");
      return comment;
    } on DioException catch (e, str) {
       debugPrint("HATA: $e, $str");
       return null;
    }

  }


  /// Get all comments from database
  /// Works properly
  Future<List<Comment>> getAllComments() async {
  
    try{
      final response = await dio.get("$baseUrl/Comment/getAll", options: options);
      debugPrint("response: $response");
      List<Comment> comments = [];

      List? responseData = response.data;

      if(responseData != null && responseData.isNotEmpty){
        for(int i = 0; i < responseData.length; i++){
          comments.add(Comment.fromJson(responseData[i]));
        }
      }

      return comments;
    } on DioException catch (e, str) {
       debugPrint("HATA: $e, $str");
       return [];
    }

  }



  /// Delete comment with [commentId]
  /// Works properly
  Future<bool?> deleteCommentByID({required int commentId}) async {
  
    try{
      final response = await dio.delete("$baseUrl/Comment/delete", queryParameters: {"id" : commentId}, options: options);
      debugPrint("response: $response");
      return true;
    } on DioException catch (e, str) {
       debugPrint("HATA: $e, $str");
       return false;
    }

  }


  /// Update comment with [comment] object.
  /// Works properly
  Future<bool?> updateBooking({required Comment comment}) async {
  
    try{
      
      var data = comment.toJson();
      debugPrint("data: $data");
      final response = await dio.put("$baseUrl/Comment/update", queryParameters: data, options: options);
      debugPrint("response: $response");
      return true;
    } on DioException catch (e, str) {
       debugPrint("HATA: $e, $str");
       return false;
    }

  }


}