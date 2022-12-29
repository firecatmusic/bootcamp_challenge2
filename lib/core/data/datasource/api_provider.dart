import 'dart:convert';

import 'package:bootcamp_challenge2/core/data/model/listnote_response.dart';
import 'package:bootcamp_challenge2/core/data/model/register_response.dart';
import 'package:dio/dio.dart';
import 'package:dio_logging_interceptor/dio_logging_interceptor.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../config/config.dart';
import '../model/getprofile_response.dart';
import '../model/gettoken_response.dart';
import '../model/login_response.dart';

class ApiProvider {
  Future<Dio> get _dio async {
    final dio = Dio(
      BaseOptions(baseUrl: Config.baseUrl, sendTimeout: Config.timeout, connectTimeout: Config.timeout, receiveTimeout: Config.timeout),
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
      var response = await dio.get("api/user/get-token");
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
      // dio.options.headers['content-Type'] = 'application/x-www-form-urlencoded';
      var param = FormData.fromMap({"email": email, "password": password});
      var response = await dio.post("api/user/login?expired=0", data: param);
      return LoginResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      if (error is DioError) {
        return LoginResponse.withError("${error.error}");
      } else {
        if (kDebugMode) {
          print("Exception occured: $error, stacktrace: $stacktrace");
        }
        return LoginResponse.withError(error.toString());
      }
    }
  }

  Future<RegisterResponse> register(String email, String password, String name) async {
    try {
      final dio = await _dio;
      // dio.options.headers['content-Type'] = 'application/x-www-form-urlencoded';
      var param = FormData.fromMap({"email": email, "password": password, "name": name});
      var response = await dio.post("api/user", data: param);
      return RegisterResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      if (error is DioError) {
        return RegisterResponse.withError("${error.error}");
      } else {
        if (kDebugMode) {
          print("Exception occured: $error, stacktrace: $stacktrace");
        }
        return RegisterResponse.withError(error.toString());
      }
    }
  }

  Future<ProfileResponse> getProfile() async {
    try {
      final dio = await _dio;
      var response = await dio.get("api/user/profile");
      return ProfileResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      if (kDebugMode) {
        print("Exception occured: $error, stacktrace: $stacktrace");
      }
      if (error is DioError) {
        return ProfileResponse.withError("${error.error}");
      } else {
        return ProfileResponse.withError(error.toString());
      }
    }
  }

  Future<ListNoteResponse> getAllNote() async {
    try {
      final dio = await _dio;
      var response = await dio.get("api/note/");
      return ListNoteResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      if (kDebugMode) {
        print("Exception occured: $error, stacktrace: $stacktrace");
      }
      if (error is DioError) {
        return ListNoteResponse.withError("${error.error}");
      } else {
        return ListNoteResponse.withError(error.toString());
      }
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
