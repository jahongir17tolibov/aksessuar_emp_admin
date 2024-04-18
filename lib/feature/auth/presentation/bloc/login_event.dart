part of 'login_bloc.dart';

sealed class LoginEvent {}

class LoginOnGetAdminDataEvent extends LoginEvent {}

class LoginOnSubmitAuthEvent extends LoginEvent {
  final String login;
  final String password;

  LoginOnSubmitAuthEvent(this.login, this.password);
}
