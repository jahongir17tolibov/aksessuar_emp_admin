import 'dart:async';

import 'package:aksessuar_emp_admin/core/helpers/use_case_helpers.dart';
import 'package:aksessuar_emp_admin/feature/auth/domain/model/admin_model.dart';
import 'package:aksessuar_emp_admin/feature/auth/domain/repository/auth_repository.dart';

class GetAdminDataUseCase implements BaseUseCase<AdminModel?> {
  GetAdminDataUseCase({required AuthRepository repository}) : _repository = repository;

  final AuthRepository _repository;

  @override
  Future<AdminModel?> execute() => _repository.getAdminData();
}
