import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class AdminDto extends Equatable {
  const AdminDto(this.id, this.login, this.password, this.registeredTime);

  final String id;
  final String login;
  final String password;
  final Timestamp registeredTime;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'login': login,
        'password': password,
        'registered_time': registeredTime,
      };

  factory AdminDto.fromJson(Map<String, dynamic> json) => AdminDto(
        json['id'] as String,
        json['login'] as String,
        json['password'] as String,
        json['registered_time'] as Timestamp,
      );

  @override
  List<Object?> get props => [id, login, password, registeredTime];
}
