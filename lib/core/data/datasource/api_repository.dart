import 'package:bootcamp_challenge2/core/data/datasource/api_provider.dart';
import 'package:bootcamp_challenge2/core/data/model/login_response.dart';

import '../model/gettoken_response.dart';

class ApiRepository {
  final _provider = ApiProvider();

  Future<GetTokenResponse> getToken() {
    return _provider.getToken();
  }

  Future<LoginResponse> login(String email, String password) {
    return _provider.login(email, password);
  }
}

class NetworkError extends Error {}
