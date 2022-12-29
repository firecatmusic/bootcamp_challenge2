part of 'register_bloc.dart';

@immutable
abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  List<Object> get props => [];
}

class RegisterUserEvent extends RegisterEvent {
  String email;
  String password;
  String name;

  RegisterUserEvent(this.email, this.password, this.name);
}
