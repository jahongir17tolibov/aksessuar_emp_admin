import 'package:aksessuar_emp_admin/feature/auth/data/remote/util/auth_result.dart';
import 'package:aksessuar_emp_admin/feature/auth/domain/model/user_model.dart';

abstract interface class AuthRepository {
  Future<AuthResult<UserModel>> registerUserByEmail({required String email, required String password});

  Future<AuthResult<UserModel>> loginWithEmail({required String email, required String password});

  Future<AuthResult<UserModel>> signInWithGoogle();

  Future<UserModel?> getFirebaseUser();

  Future<void> saveUserUId({required uid});

  Future<String?> getUserUId();
}
