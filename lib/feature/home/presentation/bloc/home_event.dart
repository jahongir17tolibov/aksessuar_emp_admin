part of 'home_bloc.dart';

sealed class HomeEvent {}

class HomeOnGetUsersOrderListEvent extends HomeEvent {}

class HomeOnAddNewRandomTestDataEvent extends HomeEvent {}

class HomeOnDeleteTestDataEvent extends HomeEvent {
  final String docId;

  HomeOnDeleteTestDataEvent(this.docId);
}

class HomeOnClickAcceptToSignOutEvent extends HomeEvent {}
