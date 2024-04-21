import 'package:flutter/cupertino.dart';

@immutable
class AuthModel {
  const AuthModel({required this.email, required this.password});

  final String email;
  final String password;
}
