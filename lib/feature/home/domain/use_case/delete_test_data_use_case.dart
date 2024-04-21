import 'package:aksessuar_emp_admin/core/helpers/use_case_helpers.dart';
import 'package:aksessuar_emp_admin/feature/home/domain/repository/home_repository.dart';

class DeleteTestDataUseCase implements BaseUseCaseWithParams<String, void> {
  DeleteTestDataUseCase({required HomeRepository repository}) : _repository = repository;
  final HomeRepository _repository;

  @override
  Future<void> execute(String id) => _repository.deleteTestData(id: id);
}
