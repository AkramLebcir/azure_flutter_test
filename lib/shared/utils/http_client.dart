import 'package:dio/dio.dart';
// import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'http_interceptors/auth_interceptor.dart';
import 'http_interceptors/error_interceptor.dart';

// FIXME: Use a legit dependency injector instead of a Singleton
class HttpClient {
  HttpClient._internal();

  static final _singleton = HttpClient._internal();

  factory HttpClient() => _singleton;

  final dio = createDio();

  Dio init() {
    Dio dio = Dio(BaseOptions(baseUrl: ''));

    // dio.interceptors..add(AuthInterceptor(dio))..add(ErrorInterceptor());
    return dio;
  }

  static Dio createDio() {
    var dio = Dio(BaseOptions(baseUrl: ''));

    dio.interceptors..add(AuthInterceptor(dio))..add(ErrorInterceptor());

    if (kDebugMode) {
      dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: false,
          requestBody: true,
          responseHeader: false,
          responseBody: true,
        ),
      );
    }
    return dio;
  }
}
