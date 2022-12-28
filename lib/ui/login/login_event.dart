part of 'login_bloc.dart';

@immutable
abstract class LoginEvent extends Equatable {
  const LoginEvent();

  List<Object> get props => [];
}

class GetTokenEvent extends LoginEvent {
  String email;
  String password;

  GetTokenEvent(this.email, this.password);
}
