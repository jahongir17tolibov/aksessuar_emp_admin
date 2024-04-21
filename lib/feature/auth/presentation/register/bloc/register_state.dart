part of 'register_bloc.dart';

enum RegisterStatus { pure, initial, onError, isAuthenticated, showMessage }

@immutable
class RegisterState extends Equatable {
  const RegisterState({
    required this.status,
    this.isLoading = false,
    this.messageForSnackBar,
    this.error,
  });

  final RegisterStatus status;
  final bool isLoading;
  final String? messageForSnackBar;
  final String? error;

  RegisterState copyWith({
    RegisterStatus? status,
    bool? isLoading,
    String? messageForSnackBar,
    String? error,
  }) =>
      RegisterState(
        status: status ?? this.status,
        isLoading: isLoading ?? this.isLoading,
        messageForSnackBar: messageForSnackBar ?? this.messageForSnackBar,
        error: error ?? this.error,
      );

  @override
  List<Object?> get props => [status, isLoading, messageForSnackBar, error];
}
