
import 'package:dio/dio.dart';
import 'package:dormitory_management/models/users/user.dart';
import 'package:flutter/material.dart';

abstract class Api {

  String baseUrl = "https://localhost:7247/api";
  String baseUrlVanilla = "localhost:7247";
  String port = "0";

  String adminUrl ="Admin";
  String userUrl ="User";
 
  Options options = Options(contentType: Headers.jsonContentType, headers: {"accept" : "*/*"});

  final dio = Dio();

  Future<User?> login({required String email, required String password}) async {
    final response = await dio.get("$baseUrl/Login");
      debugPrint("response: $response");
  }





}