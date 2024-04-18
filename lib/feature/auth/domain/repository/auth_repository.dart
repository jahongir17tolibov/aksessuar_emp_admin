import 'package:aksessuar_emp_admin/feature/auth/domain/model/admin_model.dart';

abstract interface class AuthRepository {
  Future<void> syncAdminData();

  Future<AdminModel?> getAdminData();
}
