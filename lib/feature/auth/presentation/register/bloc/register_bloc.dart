import 'dart:async';

import 'package:aksessuar_emp_admin/feature/auth/domain/model/auth_model.dart';
import 'package:aksessuar_emp_admin/feature/auth/domain/model/user_model.dart';
import 'package:aksessuar_emp_admin/feature/auth/domain/use_case/register_user_by_email_use_case.dart';
import 'package:aksessuar_emp_admin/feature/auth/domain/use_case/save_user_uid_use_case.dart';
import 'package:aksessuar_emp_admin/feature/auth/domain/use_case/sign_in_with_google_use_case.dart';
import 'package:aksessuar_emp_admin/utils/email_extension.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'register_event.dart';

part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc({
    required this.registerUserByEmailUseCase,
    required this.saveUserUIdUseCase,
    required this.signInWithGoogleUseCase,
  }) : super(const RegisterState(status: RegisterStatus.initial)) {
    on<RegisterOnClickRegisterBtnEvent>(_onClickRegisterBtnEvent);

    on<RegisterOnClickGoogleBtnEvent>(_onClickGoogleBtnEvent);
  }

  final RegisterUserByEmailUseCase registerUserByEmailUseCase;
  final SaveUserUIdUseCase saveUserUIdUseCase;
  final SignInWithGoogleUseCase signInWithGoogleUseCase;

  final TextEditingController emailEditingController = TextEditingController();
  final TextEditingController passwordEditingController = TextEditingController();
  final TextEditingController reEnterPasswordEditingController = TextEditingController();

  FutureOr<void> _onClickRegisterBtnEvent(
    RegisterOnClickRegisterBtnEvent event,
    Emitter<RegisterState> emit,
  ) async {
    try {
      final String email = emailEditingController.text;
      final String password = passwordEditingController.text;
      final String reEnteredPassword = reEnterPasswordEditingController.text;
      final authModel = AuthModel(email: email, password: password);
      if (email.validateEmail()) {
        if (password.length >= 8) {
          if (password == reEnteredPassword) {
            emit(state.copyWith(isLoading: true));
            await registerUserByEmailUseCase.execute(authModel).then((result) async {
              await _saveUserIfDataNotNull(user: result.data, emit: emit);

              String? errorMsg = result.errorMessage;
              if (result.errorMessage != null) {
                _showSnackMsg(errorMsg!, emit: emit);
              }
            });
          } else {
            const String msg = "reentered password doesn't match";
            _showSnackMsg(msg, emit: emit);
          }
        } else {
          const String msg = "The length of the password should not be less than 8 characters!";
          _showSnackMsg(msg, emit: emit);
        }
      } else {
        _showSnackMsg('Incorrect email format', emit: emit);
      }
    } catch (e) {
      _showSnackMsg('sign up failed, try again', emit: emit);
    }
  }

  FutureOr<void> _onClickGoogleBtnEvent(
    RegisterOnClickGoogleBtnEvent event,
    Emitter<RegisterState> emit,
  ) async {
    try {
      await signInWithGoogleUseCase.execute().then((result) async {
        await _saveUserIfDataNotNull(user: result.data, emit: emit);

        String? errorMsg = result.errorMessage;
        if (result.errorMessage != null) {
          emit(state.copyWith(status: RegisterStatus.onError, error: errorMsg!));
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

  void _showSnackMsg(String msg, {required Emitter<RegisterState> emit}) {
    emit(state.copyWith(
      status: RegisterStatus.showMessage,
      isLoading: false,
      messageForSnackBar: msg,
    ));
    emit(state.copyWith(status: RegisterStatus.initial));
  }

  FutureOr<void> _saveUserIfDataNotNull({
    required UserModel? user,
    required Emitter<RegisterState> emit,
  }) async {
    if (user != null) {
      await saveUserUIdUseCase.execute(user.id!).whenComplete(() {
        emit(state.copyWith(
          status: RegisterStatus.showMessage,
          isLoading: false,
          messageForSnackBar: "Successful!",
        ));
        emit(state.copyWith(status: RegisterStatus.isAuthenticated));
      });
    }
  }
}
