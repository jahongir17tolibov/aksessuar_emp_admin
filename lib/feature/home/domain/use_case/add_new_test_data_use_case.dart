import 'package:aksessuar_emp_admin/core/helpers/use_case_helpers.dart';
import 'package:aksessuar_emp_admin/feature/home/domain/model/users_order_model.dart';
import 'package:aksessuar_emp_admin/feature/home/domain/repository/home_repository.dart';

class AddNewTestDataUseCase implements BaseUseCaseWithParams<UsersOrderModel, void> {
  AddNewTestDataUseCase({required HomeRepository repository}) : _repository = repository;

  final HomeRepository _repository;

  @override
  Future<void> execute(UsersOrderModel usersOrderModel) =>
      _repository.addNewTestData(usersOrderModel: usersOrderModel);
}
