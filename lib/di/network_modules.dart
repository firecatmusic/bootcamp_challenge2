import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio_logging_interceptor/dio_logging_interceptor.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import '../core/utils/refresh_token_interceptor.dart';
import 'injection.dart';

import '../core/config/config.dart';

@module
abstract class NetworkModule {
  @dev
  Dio get client {
    final dio = Dio(
      BaseOptions(
        baseUrl: Config.baseUrl,
        sendTimeout: Config.timeout,
        connectTimeout: Config.timeout,
        receiveTimeout: Config.timeout,
      ),
    );

    dio.interceptors.add(DioLoggingInterceptor(level: Level.body, compact: false));
    dio.interceptors.add(getIt<RefreshTokenInterceptor>());

    final f = DateFormat('yyyy-MM-dd');
    dio.options.headers["Authorization"] = "${base64.encode(utf8.encode(f.format(DateTime.now())))}|rahasia";

    return dio;
  }
}
