import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bootcamp_challenge2/core/data/model/gettoken_response.dart';
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
        final response = await apiRepo.getToken();
        if (response.message == "success") {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('token', response.token.toString());
          final String? token = prefs.getString('token');
          print("token: $token");
        }else{
          emit(LoginError(response.message.toString()));
        }
      } on NetworkError {
        emit(const LoginError("Connection Error"));
      }
    });
  }
}
