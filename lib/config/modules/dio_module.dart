import 'package:dio/dio.dart';
import 'package:exam_app/config/Di/di.dart';
import 'package:exam_app/config/network/auth_interceptors.dart';
import 'package:flutter/foundation.dart';

import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

@module
abstract class DioModule {
  @singleton
  Dio provideDio() {
    Dio dio = Dio();
    dio.options = BaseOptions(
      receiveTimeout: Duration(seconds: 60),
      connectTimeout: Duration(seconds: 60),
      sendTimeout: Duration(seconds: 60),
    );
    dio.interceptors.add(getIt<AuthInterceptors>());
    if (kDebugMode) {
      dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          error: true,
          compact: true,
          maxWidth: 90,
        ),
      );
    }
    return dio;
  }
}
