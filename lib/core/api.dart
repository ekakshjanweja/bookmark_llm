import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

//Base URL

const String baseURL = "https://my-app.kunalverma01357.workers.dev";

//Default Headers

const Map<String, dynamic> defaultHeaders = {
  "Content-Type": "application/json",
};

//API Class

class Api {
  final Dio _dio = Dio();

  Api() {
    _dio.options.baseUrl = baseURL;

    _dio.options.headers = defaultHeaders;

    _dio.interceptors.add(PrettyDioLogger(
      requestBody: true,
      requestHeader: true,
      responseBody: true,
      responseHeader: true,
    ));
  }

  //Dio Getter -> sendRequest

  Dio get sendRequest => _dio;
}

//API Response Class

class ApiResponse {
  bool success;
  dynamic data;

  ApiResponse({
    required this.success,
    required this.data,
  });

  factory ApiResponse.fromResponse(Response response) {
    var data = jsonDecode(response.toString());

    return ApiResponse(
      success: data["success"],
      data: data["data"] as Map<String, dynamic>,
    );
  }
}
