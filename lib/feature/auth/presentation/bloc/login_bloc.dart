import 'dart:async';

import 'package:aksessuar_emp_admin/feature/auth/domain/model/admin_model.dart';
import 'package:aksessuar_emp_admin/feature/auth/domain/use_case/get_admin_data_use_case.dart';
import 'package:aksessuar_emp_admin/feature/auth/domain/use_case/sync_admin_data_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({
    required this.getAdminDataUseCase,
    required this.syncAdminDataUseCase,
  }) : super(const LoginState(status: LoginStatus.pure)) {
    on<LoginOnGetAdminDataEvent>(_onGetAdminDataEvent);

    on<LoginOnSubmitAuthEvent>(_onSubmitAuthEvent);
  }

  final GetAdminDataUseCase getAdminDataUseCase;
  final SyncAdminDataUseCase syncAdminDataUseCase;

  FutureOr<void> _onGetAdminDataEvent(
    LoginOnGetAdminDataEvent event,
    Emitter<LoginState> emit,
  ) async {
    try {
      emit(state.copyWith(status: LoginStatus.initial, isLoading: true));
      await syncAdminDataUseCase.execute();

      await getAdminDataUseCase.execute().then((data) {
        (data != null)
            ? emit(state.copyWith(isLoading: false, adminData: data))
            : emit(state.copyWith(
                status: LoginStatus.onError,
                error: "admin ma'lumotlari bo'sh((",
              ));
      });
    } catch (e) {
      emit(state.copyWith(
        status: LoginStatus.onError,
        error: e.toString(),
      ));
    }
  }

  FutureOr<void> _onSubmitAuthEvent(
    LoginOnSubmitAuthEvent event,
    Emitter<LoginState> emit,
  ) {}
}
