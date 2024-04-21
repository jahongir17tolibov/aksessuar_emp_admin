import 'package:aksessuar_emp_admin/feature/home/domain/model/users_order_model.dart';
import 'package:aksessuar_emp_admin/feature/home/domain/repository/home_repository.dart';

class GetUsersOrderDataReactiveUseCase {
  GetUsersOrderDataReactiveUseCase({required HomeRepository repository}) : _repository = repository;

  final HomeRepository _repository;

  Stream<List<UsersOrderModel>> execute() => _repository.getUsersOrderDataReactive();
}
