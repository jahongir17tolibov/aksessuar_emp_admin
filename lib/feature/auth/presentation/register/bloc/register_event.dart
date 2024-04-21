part of 'register_bloc.dart';

sealed class RegisterEvent {}

class RegisterOnClickGoogleBtnEvent extends RegisterEvent {}

class RegisterOnClickRegisterBtnEvent extends RegisterEvent {}
