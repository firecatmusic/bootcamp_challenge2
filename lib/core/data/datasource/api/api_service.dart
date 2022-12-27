import 'package:bootcamp_challenge2/core/data/model/gettoken_response.dart';
import 'package:bootcamp_challenge2/core/data/model/login_response.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/http.dart';

import '../../model/api_response.dart';

part '../../../../gen/core/data/datasource/api/api_service.g.dart';

@RestApi()
@Injectable() // dependensi yang diperlukan oleh kelas dengan anotasi injectable akan diresolve otomatis
abstract class ApiService {
  @factoryMethod // diperlukan anotasi factoryMethod jika objek dibuat menggunakan factory
  factory ApiService(Dio dio) = _ApiService;

  // sisanya sama persis seperti retrofit di android
  @GET('user/get-token')
  Future<ApiResponse<GetTokenResponse>> getToken();

  @GET('user')
  Future<ApiResponse<GetTokenResponse>> register(@Field("name") String name, @Field("email") String email, @Field("password") String password);

  @GET('user/login?expired={isExpired}')
  Future<ApiResponse<LoginResponse>> login(@Path('isExpired') String isExpired, @Field("email") String email, @Field("password") String password);
}
