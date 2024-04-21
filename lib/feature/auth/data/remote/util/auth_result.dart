import 'package:equatable/equatable.dart';

class AuthResult<T> extends Equatable {
  const AuthResult({this.data, this.errorMessage});

  final T? data;
  final String? errorMessage;

  @override
  List<Object?> get props => [data, errorMessage];
}
