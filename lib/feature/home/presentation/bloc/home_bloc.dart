import 'dart:async';
import 'dart:math';

import 'package:aksessuar_emp_admin/feature/auth/domain/model/user_model.dart';
import 'package:aksessuar_emp_admin/feature/auth/domain/use_case/get_firebase_user_use_case.dart';
import 'package:aksessuar_emp_admin/feature/home/domain/model/users_order_model.dart';
import 'package:aksessuar_emp_admin/feature/home/domain/use_case/add_new_test_data_use_case.dart';
import 'package:aksessuar_emp_admin/feature/home/domain/use_case/delete_test_data_use_case.dart';
import 'package:aksessuar_emp_admin/feature/home/domain/use_case/get_users_order_data_reactive_use_case.dart';
import 'package:aksessuar_emp_admin/feature/home/domain/use_case/sign_out_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({
    required this.getUsersOrderDataReactiveUseCase,
    required this.addNewTestDataUseCase,
    required this.signOutUseCase,
    required this.getFirebaseUserUseCase,
    required this.deleteTestDataUseCase,
  }) : super(const HomeState(status: HomeStatus.pure)) {
    on<HomeOnGetUsersOrderListEvent>(_onGetUsersOrderListEvent);

    on<HomeOnAddNewRandomTestDataEvent>(_onAddNewRandomTestDataEvent);

    on<HomeOnClickAcceptToSignOutEvent>(_onClickAcceptToSignOutEvent);

    on<HomeOnDeleteTestDataEvent>(_onDeleteTestDataEvent);
  }

  final GetUsersOrderDataReactiveUseCase getUsersOrderDataReactiveUseCase;
  final AddNewTestDataUseCase addNewTestDataUseCase;
  final DeleteTestDataUseCase deleteTestDataUseCase;
  final SignOutUseCase signOutUseCase;
  final GetFirebaseUserUseCase getFirebaseUserUseCase;

  FutureOr<void> _onGetUsersOrderListEvent(
    HomeOnGetUsersOrderListEvent event,
    Emitter<HomeState> emit,
  ) async {
    try {
      emit(state.copyWith(status: HomeStatus.onLoading));
      await getFirebaseUserUseCase.execute().then((user) => emit(state.copyWith(userModel: user)));

      await emit.onEach<List<UsersOrderModel>>(
        getUsersOrderDataReactiveUseCase.execute(),
        onData: (usersOrderData) async {
          if (usersOrderData.isNotEmpty) {
            usersOrderData.sort((a, b) => a.number!.toInt().compareTo(b.number!.toInt()));
            emit(state.copyWith(status: HomeStatus.onSuccess, usersOrderList: usersOrderData));
          } else {
            emit(state.copyWith(status: HomeStatus.onEmpty));
          }
        },
        onError: (e, st) {
          debugPrintStack(stackTrace: st);
          emit(state.copyWith(status: HomeStatus.onError, error: e.toString()));
        },
      );
    } catch (e) {
      emit(state.copyWith(status: HomeStatus.onError, error: e.toString()));
    }
  }

  FutureOr<void> _onAddNewRandomTestDataEvent(
    HomeOnAddNewRandomTestDataEvent event,
    Emitter<HomeState> emit,
  ) async {
    try {
      final Random random = Random();
      final usersOrderModelWithRandomData = UsersOrderModel(
        number: state.usersOrderList!.last.number! + 1,
        amount: random.nextInt(40001) + 5000,
        ordersThisMonth: random.nextInt(71) + 50,
      );
      await addNewTestDataUseCase.execute(usersOrderModelWithRandomData);
    } catch (e) {
      emit(state.copyWith(status: HomeStatus.onError, error: e.toString()));
    }
  }

  FutureOr<void> _onDeleteTestDataEvent(
    HomeOnDeleteTestDataEvent event,
    Emitter<HomeState> emit,
  ) async {
    try {
      await deleteTestDataUseCase.execute(event.docId);
    } catch (e) {
      emit(state.copyWith(status: HomeStatus.onError, error: e.toString()));
    }
  }

  FutureOr<void> _onClickAcceptToSignOutEvent(
    HomeOnClickAcceptToSignOutEvent event,
    Emitter<HomeState> emit,
  ) async {
    try {
      await signOutUseCase.execute().whenComplete(() {
        emit(state.copyWith(status: HomeStatus.onSignOut));
      });
    } catch (e) {
      emit(state.copyWith(status: HomeStatus.onError, error: e.toString()));
    }
  }
}
