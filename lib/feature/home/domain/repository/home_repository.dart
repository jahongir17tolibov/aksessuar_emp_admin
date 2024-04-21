import 'dart:async';

import 'package:aksessuar_emp_admin/feature/home/domain/model/users_order_model.dart';

abstract interface class HomeRepository {
  Stream<List<UsersOrderModel>> getUsersOrderDataReactive();

  Future<void> addNewTestData({required UsersOrderModel usersOrderModel});

  Future<void> deleteTestData({required String id});

  Future<void> signOutFromFirebase();
}
