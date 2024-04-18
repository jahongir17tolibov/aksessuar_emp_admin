import 'dart:async';

import 'package:aksessuar_emp_admin/core/helpers/use_case_helpers.dart';
import 'package:aksessuar_emp_admin/feature/auth/domain/repository/auth_repository.dart';

class SyncAdminDataUseCase implements BaseUseCase<void> {
  SyncAdminDataUseCase({required AuthRepository repository}) : _repository = repository;

  final AuthRepository _repository;

  @override
  Future<void> execute() => _repository.syncAdminData();
}
