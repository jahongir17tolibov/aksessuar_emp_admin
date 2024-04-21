import 'package:aksessuar_emp_admin/feature/auth/data/remote/dto/user_dto.dart';
import 'package:aksessuar_emp_admin/feature/auth/data/remote/util/auth_result.dart';

abstract interface class AuthRemoteDataSource {
  Future<AuthResult<UserDto>> createUserByEmail(String email, String password);

  Future<AuthResult<UserDto>> signInUserByEmail(String email, String password);

  Future<AuthResult<UserDto>> signInByGoogle();

  Future<UserDto?> getSignedUser();
}
