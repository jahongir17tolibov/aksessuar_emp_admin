part of 'login_bloc.dart';

enum LoginStatus { initial, pure, onError, showMessage, isValid }

@immutable
class LoginState extends Equatable {
  const LoginState({
    required this.status,
    this.adminData,
    this.isLoading,
    this.messageForSnackBar,
    this.error,
  });

  final LoginStatus status;
  final AdminModel? adminData;
  final bool? isLoading;
  final String? messageForSnackBar;
  final String? error;

  LoginState copyWith({
    LoginStatus? status,
    AdminModel? adminData,
    bool? isLoading,
    String? messageForSnackBar,
    String? error,
  }) =>
      LoginState(
        status: status ?? this.status,
        adminData: adminData ?? this.adminData,
        isLoading: isLoading ?? this.isLoading,
        messageForSnackBar: messageForSnackBar ?? this.messageForSnackBar,
        error: error ?? this.error,
      );

  @override
  List<Object?> get props => [status, adminData, isLoading, messageForSnackBar, error];
}
