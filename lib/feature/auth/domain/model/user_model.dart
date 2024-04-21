import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
class UserModel extends Equatable {
  const UserModel({this.id, this.email, this.userName, this.profileImg});

  final String? id;
  final String? email;
  final String? userName;
  final String? profileImg;

  @override
  List<Object?> get props => [id, email, userName, profileImg];
}
