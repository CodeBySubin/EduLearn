import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lms_project/core/constants.dart';

class ApiClient {
  late final Dio _dio;

  ApiClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: APIConfig.baseURL,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          debugPrint("[API REQUEST] ${options.method} → ${options.uri}");
          if (options.data != null) debugPrint("[BODY] ${options.data}");
          return handler.next(options);
        },
        onResponse: (response, handler) {
          debugPrint("[API RESPONSE] ${response.statusCode} → ${response.requestOptions.uri}");
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          debugPrint("[API ERROR] ${e.message}");
          if (e.response != null) {
            debugPrint("[ERROR DETAILS] ${e.response?.statusCode} → ${e.response?.data}");
          }
          return handler.next(e);
        },
      ),
    );
  }

  /// **GET Request**
  Future<Response> get(String endpoint, {Map<String, dynamic>? params}) async {
      return await _dio.get(endpoint, queryParameters: params);
  }
  
  /// **POST Request**
  Future<Response> post(String endpoint, {dynamic data}) async {
      return await _dio.post(endpoint, data: data);
  }
}
