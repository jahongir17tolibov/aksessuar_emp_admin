import 'package:equatable/equatable.dart';

class AdminModel extends Equatable {
  const AdminModel({
    required this.id,
    required this.login,
    required this.password,
    required this.registeredTime,
  });

  final String id;
  final String login;
  final String password;
  final String registeredTime;

  @override
  List<Object?> get props => [id, login, password, registeredTime];
}
