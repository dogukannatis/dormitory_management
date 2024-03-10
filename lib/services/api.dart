
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Api {

  static String baseUrl = "https://localhost/api/";
  static String port = "0";

  static String adminUrl ="Admin";

  final dio = Dio();

  Future<void> getAllAdmins({required String token}) async {

    try{
      final response = await dio.get("$adminUrl/add", options: Options(headers: {"authorization": "Bearer $token"}));
      debugPrint("response: $response");

      if(response.statusCode == 200){
        debugPrint("Data: ${response.data}");

        // User user = User.fromMap(response.data);
        // user.token = token;

        // debugPrint(user.toString());
        // return user;

      }else{
        debugPrint("Hata: ${response.statusCode} ${response.statusMessage}");
        throw "response code: ${response.statusCode}";
      }


    } on DioException catch(e, str){
      debugPrint("HATA: $e $str");
      debugPrint(e.response.toString());
      debugPrint(e.message);
    }




  }







}