part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LoginEvent extends AuthEvent {
  LoginParams params;

   LoginEvent(this.params);
  @override
  List<String> get props => [];
}

class LogoutEvent extends AuthEvent {
  const LogoutEvent();
  @override
  List<String> get props => [];
}

class CheckStatus extends AuthEvent {
  const CheckStatus();
  @override
  List<String> get props => [];
}

class SendToken extends AuthEvent {
  const SendToken();
  @override
  List<String> get props => [];
}
