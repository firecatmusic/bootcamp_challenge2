import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../core/data/datasource/api_repository.dart';
import '../../core/data/model/register_response.dart';

part 'register_event.dart';

part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial()) {
    final _api = ApiRepository();

    on<RegisterUserEvent>((event, emit) async {
      emit(RegisterLoading());

      var email = event.email;
      var password = event.password;
      var name = event.name;

      print("email: $email, password: $password, name: $name");

      final response = await _api.register(email, password, name);
      if (response.message == "user created") {
        emit(RegisterSuccess(response));
      } else {
        emit(RegisterError(response.message));
      }
    });
  }
}
