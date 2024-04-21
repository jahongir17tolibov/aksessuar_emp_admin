import 'package:equatable/equatable.dart';

class UserDto extends Equatable {
  const UserDto({this.userUId, this.email, this.userName, this.userProfileUrl});

  final String? userUId;
  final String? email;
  final String? userName;
  final String? userProfileUrl;

  @override
  List<Object?> get props => [userUId, email, userName, userProfileUrl];
}
