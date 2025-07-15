import 'dart:developer';

import 'package:dio/dio.dart';

class DioHandler {
  final Dio dio;
  // Here we create DioHandler constructor
  // This constructor will be moved to depends of this application
  DioHandler()
    : dio = Dio(
        BaseOptions(
          baseUrl: "http://localhost:8080",
          connectTimeout: Duration(milliseconds: 5000),
          receiveTimeout: Duration(milliseconds: 3000),
        ),
      ) {
    log("Dio handler built");
  }
}
