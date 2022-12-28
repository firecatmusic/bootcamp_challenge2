import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bootcamp_challenge2/core/data/datasource/sharedpref/shared_pref.dart';
import 'package:bootcamp_challenge2/core/data/model/gettoken_response.dart';
import 'package:bootcamp_challenge2/core/data/model/login_response.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/data/datasource/api_repository.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(Initial()) {
    final apiRepo = ApiRepository();

    on<GetTokenEvent>((event, emit) async {
      try {
        emit(Loading());

        var email = event.email;
        var password = event.password;
        print("email: $email, password:$password");

        final responseToken = await apiRepo.getToken();
        if (responseToken.message == "success") {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('token', responseToken.token.toString());
          final String? token = prefs.getString('token');
          print("token: $token");

          final responseLogin = await apiRepo.login(email, password);
          if (responseLogin.message == "success") {
            SharedPref().saveJson("user", responseLogin.toJson());
            emit(LoginSuccess(responseLogin));
          } else {
            emit(LoginError(responseLogin.message.toString()));
          }
        } else {
          emit(LoginError(responseToken.message.toString()));
        }
      } on NetworkError {
        emit(const LoginError("Connection Error"));
      }
    });
  }
}
