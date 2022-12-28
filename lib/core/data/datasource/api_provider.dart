import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio_logging_interceptor/dio_logging_interceptor.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../config/config.dart';
import '../model/gettoken_response.dart';
import '../model/login_response.dart';

class ApiProvider {
  Future<Dio> get _dio async {
    final dio = Dio(
      BaseOptions(
        baseUrl: Config.baseUrl,
        sendTimeout: Config.timeout,
        connectTimeout: Config.timeout,
        receiveTimeout: Config.timeout
      ),
    );

    dio.interceptors.add(DioLoggingInterceptor(level: Level.body, compact: false));
    // dio.interceptors.add(getIt<RefreshTokenInterceptor>());
    // Obtain shared preferences.
    dio.options.headers["Authorization"] = await getExistingToken();
    return dio;
  }

  Future<GetTokenResponse> getToken() async {
    try {
      final dio = await _dio;
      Response response = dio.get("api/user/get-token") as Response;
      return GetTokenResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      if (kDebugMode) {
        print("Exception occured: $error, stacktrace: $stacktrace");
      }
      return GetTokenResponse.withError(error.toString());
    }
  }

  Future<LoginResponse> login(String email, String password) async {
    try {
      final dio = await _dio;
      dio.options.headers['content-Type'] = 'application/x-www-form-urlencoded';
      Response response = dio.post("api/user/login?expired=0") as Response;
      return LoginResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      if (kDebugMode) {
        print("Exception occured: $error, stacktrace: $stacktrace");
      }
      return LoginResponse.withError(error.toString());
    }
  }

  Future<String> getExistingToken() async {
    // Obtain shared preferences.
    final prefs = await SharedPreferences.getInstance();
    final f = DateFormat('yyyy-MM-dd');
    // Try reading data from the 'action' key. If it doesn't exist, returns null.
    final String? token = prefs.getString('token');
    if (token == null) {
      print(base64.encode(utf8.encode("${f.format(DateTime.now())}|rahasia")));
      return base64.encode(utf8.encode("${f.format(DateTime.now())}|rahasia"));
    } else {
      print(token);
      return token;
    }
  }
}
