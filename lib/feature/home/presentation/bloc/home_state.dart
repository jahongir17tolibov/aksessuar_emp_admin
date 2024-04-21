part of 'home_bloc.dart';

enum HomeStatus { pure, onLoading, onSuccess, onError, onEmpty, showMessage, onSignOut }

@immutable
class HomeState extends Equatable {
  const HomeState({
    required this.status,
    this.usersOrderList,
    this.error,
    this.messageForSnackBar,
    this.userModel,
  });

  final HomeStatus status;
  final List<UsersOrderModel>? usersOrderList;
  final UserModel? userModel;
  final String? error;
  final String? messageForSnackBar;

  HomeState copyWith({
    HomeStatus? status,
    List<UsersOrderModel>? usersOrderList,
    UserModel? userModel,
    String? error,
    String? messageForSnackBar,
  }) =>
      HomeState(
        status: status ?? this.status,
        usersOrderList: usersOrderList ?? this.usersOrderList,
        userModel: userModel ?? this.userModel,
        error: error ?? this.error,
        messageForSnackBar: messageForSnackBar ?? this.messageForSnackBar,
      );

  @override
  List<Object?> get props => [status, usersOrderList, userModel, error, messageForSnackBar];
}
