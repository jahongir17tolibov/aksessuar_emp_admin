part of 'login_bloc.dart';

sealed class LoginEvent {}

class LoginOnAuthenticationEvent extends LoginEvent {}

class LoginOnClickGoogleBtnEvent extends LoginEvent {}

class LoginOnClickLoginBtnEvent extends LoginEvent {}
