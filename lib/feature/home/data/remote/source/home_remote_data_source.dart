import 'package:aksessuar_emp_admin/feature/home/data/remote/dto/users_order_dto.dart';

abstract interface class HomeRemoteDataSource {
  Future<void> addRandomTestData(UsersOrderDto usersOrderDto);

  Stream<List<UsersOrderDto>> getUsersOrderData();

  Future<void> deleteTestData(String id);

  Future<void> signOut();
}
