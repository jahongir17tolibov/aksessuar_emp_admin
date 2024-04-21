import 'package:aksessuar_emp_admin/core/helpers/use_case_helpers.dart';
import 'package:aksessuar_emp_admin/feature/auth/domain/repository/auth_repository.dart';

class SaveUserUIdUseCase implements BaseUseCaseWithParams<String, void> {
  SaveUserUIdUseCase({required AuthRepository repository}) : _repository = repository;

  final AuthRepository _repository;

  @override
  Future<void> execute(String userUid) => _repository.saveUserUId(uid: userUid);
}
