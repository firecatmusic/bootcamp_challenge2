part of 'register_bloc.dart';

@immutable
abstract class RegisterState {
  const RegisterState();

  List<Object> get props => [];
}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {
  final RegisterResponse response;

  const RegisterSuccess(this.response);
}

class RegisterError extends RegisterState {
  final String? message;

  const RegisterError(this.message);
}
