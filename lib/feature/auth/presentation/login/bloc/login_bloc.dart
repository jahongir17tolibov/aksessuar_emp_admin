import 'dart:async';

import 'package:aksessuar_emp_admin/feature/auth/domain/model/auth_model.dart';
import 'package:aksessuar_emp_admin/feature/auth/domain/model/user_model.dart';
import 'package:aksessuar_emp_admin/feature/auth/domain/use_case/get_user_uid_use_case.dart';
import 'package:aksessuar_emp_admin/feature/auth/domain/use_case/login_user_by_email_use_case.dart';
import 'package:aksessuar_emp_admin/feature/auth/domain/use_case/save_user_uid_use_case.dart';
import 'package:aksessuar_emp_admin/feature/auth/domain/use_case/sign_in_with_google_use_case.dart';
import 'package:aksessuar_emp_admin/utils/email_extension.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({
    required this.loginUserByEmailUseCase,
    required this.signInWithGoogleUseCase,
    required this.saveUserUIdUseCase,
    required this.getUserUIdUseCase,
  }) : super(const LoginState(status: LoginStatus.pure)) {
    on<LoginOnAuthenticationEvent>(_onAuthenticationStateEvent);

    on<LoginOnClickLoginBtnEvent>(_onClickLoginBtnEvent);

    on<LoginOnClickGoogleBtnEvent>(_onClickGoogleBtnEvent);

    on<LoginOnReloadingStatesEvent>(_onReloadingStatesEvent);
  }

  final LoginUserByEmailUseCase loginUserByEmailUseCase;
  final SaveUserUIdUseCase saveUserUIdUseCase;
  final SignInWithGoogleUseCase signInWithGoogleUseCase;
  final GetUserUIdUseCase getUserUIdUseCase;

  final TextEditingController emailEditingController = TextEditingController();
  final TextEditingController passwordEditingController = TextEditingController();

  FutureOr<void> _onAuthenticationStateEvent(
    LoginOnAuthenticationEvent event,
    Emitter<LoginState> emit,
  ) async {
    try {
      await getUserUIdUseCase.execute().then((uid) => (uid != null)
          ? emit(state.copyWith(status: LoginStatus.isAuthenticated))
          : emit(state.copyWith(status: LoginStatus.initial)));
    } catch (e) {
      emit(state.copyWith(status: LoginStatus.onError, error: e.toString()));
    }
  }

  FutureOr<void> _onClickLoginBtnEvent(
    LoginOnClickLoginBtnEvent event,
    Emitter<LoginState> emit,
  ) async {
    try {
      final String email = emailEditingController.text;
      final String password = passwordEditingController.text;
      final authModel = AuthModel(email: email, password: password);
      if (email.validateEmail()) {
        if (password.length >= 8) {
          emit(state.copyWith(isLoading: true));
          await loginUserByEmailUseCase.execute(authModel).then((result) async {
            await _saveUserIfDataNotNull(user: result.data, emit: emit);

            String? errorMsg = result.errorMessage;
            if (result.errorMessage != null) {
              _showSnackMsg(errorMsg!, emit: emit);
            }
          });
        } else {
          const String msg = "The length of the password should not be less than 8 characters!";
          _showSnackMsg(msg, emit: emit);
        }
      } else {
        _showSnackMsg('Incorrect email format', emit: emit);
      }
    } catch (e) {
      _showSnackMsg('Sign in, failed try again', emit: emit);
    }
  }

  FutureOr<void> _onClickGoogleBtnEvent(
    LoginOnClickGoogleBtnEvent event,
    Emitter<LoginState> emit,
  ) async {
    try {
      await signInWithGoogleUseCase.execute().then((result) async {
        await _saveUserIfDataNotNull(user: result.data, emit: emit);

        String? errorMsg = result.errorMessage;
        if (result.errorMessage != null) {
          emit(state.copyWith(status: LoginStatus.onError, error: errorMsg!));
        }
      });
    } catch (e) {
      _showSnackMsg(e.toString(), emit: emit);
    }
  }

  @override
  Future<void> close() {
    emailEditingController.dispose();
    passwordEditingController.dispose();
    return super.close();
  }

  void _showSnackMsg(String msg, {required Emitter<LoginState> emit}) {
    emit(state.copyWith(
      status: LoginStatus.showMessage,
      messageForSnackBar: msg,
      isLoading: false,
    ));
    emit(state.copyWith(status: LoginStatus.initial));
  }

  FutureOr<void> _saveUserIfDataNotNull({
    required UserModel? user,
    required Emitter<LoginState> emit,
  }) async {
    if (user != null) {
      await saveUserUIdUseCase.execute(user.id!).whenComplete(() {
        emit(state.copyWith(
          status: LoginStatus.showMessage,
          isLoading: false,
          messageForSnackBar: "Successful!",
        ));
        emit(state.copyWith(status: LoginStatus.isAuthenticated));
      });
    }
  }

  FutureOr<void> _onReloadingStatesEvent(
    LoginOnReloadingStatesEvent event,
    Emitter<LoginState> emit,
  ) {
    emit(state.copyWith(status: LoginStatus.initial, error: null));
  }
}
