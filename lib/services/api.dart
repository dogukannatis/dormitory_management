
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:dormitory_management/models/users/user.dart';
import 'package:flutter/material.dart';

  
abstract class Api {

  String baseUrl = "https://localhost:7247/api";
  String baseUrlVanilla = "localhost:7247";
  String port = "0";

  String adminUrl ="Admin";
  String userUrl ="User";
 
  Options options = Options(contentType: Headers.jsonContentType,
      headers: {
    "accept" : "*/*",
        "Access-Control-Allow-Origin": "*", // Required for CORS support to work
        "Access-Control-Allow-Credentials": true, // Required for cookies, authorization headers with HTTPS
        "Access-Control-Allow-Headers": "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
  }
  );

  final dio = Dio();


}

