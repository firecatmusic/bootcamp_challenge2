part of 'login_bloc.dart';

@immutable
abstract class LoginState {
  const LoginState();

  List<Object> get props => [];
}

class Initial extends LoginState {}

class Loading extends LoginState {}

class LoginSuccess extends LoginState {
  final LoginResponse response;

  const LoginSuccess(this.response);
}

class LoginError extends LoginState {
  final String? message;

  const LoginError(this.message);
}
