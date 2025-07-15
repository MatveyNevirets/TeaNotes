import 'dart:developer';

import 'package:dio/dio.dart';

class DioHandler {
  final Dio dio;
  DioHandler()
    : dio = Dio(
        BaseOptions(
          baseUrl: "http://localhost:8080",
          connectTimeout: Duration(milliseconds: 5000),
          receiveTimeout: Duration(milliseconds: 3000),
        ),
      ) {
    log("Dio handler build");
  }
}
