part of 'login_bloc.dart';

enum LoginStatus { pure, initial, onError, isAuthenticated, showMessage }

@immutable
class LoginState extends Equatable {
  const LoginState({
    required this.status,
    this.isLoading = false,
    this.messageForSnackBar,
    this.error,
  });

  final LoginStatus status;
  final bool isLoading;
  final String? messageForSnackBar;
  final String? error;

  LoginState copyWith({
    LoginStatus? status,
    bool? isLoading,
    String? messageForSnackBar,
    String? error,
  }) =>
      LoginState(
        status: status ?? this.status,
        isLoading: isLoading ?? this.isLoading,
        messageForSnackBar: messageForSnackBar ?? this.messageForSnackBar,
        error: error ?? this.error,
      );

  @override
  List<Object?> get props => [status, isLoading, messageForSnackBar, error];
}
