import 'dart:async';

import 'package:aksessuar_emp_admin/core/helpers/use_case_helpers.dart';
import 'package:aksessuar_emp_admin/feature/auth/data/remote/util/auth_result.dart';
import 'package:aksessuar_emp_admin/feature/auth/domain/model/auth_model.dart';
import 'package:aksessuar_emp_admin/feature/auth/domain/model/user_model.dart';
import 'package:aksessuar_emp_admin/feature/auth/domain/repository/auth_repository.dart';

class RegisterUserByEmailUseCase
    implements BaseUseCaseWithParams<AuthModel, AuthResult<UserModel?>> {
  RegisterUserByEmailUseCase({required AuthRepository repository}) : _repository = repository;

  final AuthRepository _repository;

  @override
  Future<AuthResult<UserModel?>> execute(AuthModel authModel) =>
      _repository.registerUserByEmail(email: authModel.email, password: authModel.password);
}
