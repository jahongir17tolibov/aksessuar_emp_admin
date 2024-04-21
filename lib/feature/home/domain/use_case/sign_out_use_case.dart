import 'package:aksessuar_emp_admin/core/helpers/use_case_helpers.dart';
import 'package:aksessuar_emp_admin/feature/home/domain/repository/home_repository.dart';

class SignOutUseCase implements BaseUseCase<void> {
  SignOutUseCase({required HomeRepository repository}) : _repository = repository;

  final HomeRepository _repository;

  @override
  Future<void> execute() => _repository.signOutFromFirebase();
}
