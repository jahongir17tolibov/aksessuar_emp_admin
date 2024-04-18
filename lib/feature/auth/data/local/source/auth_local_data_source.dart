import 'package:aksessuar_emp_admin/feature/auth/data/local/entity/admin_entity.dart';

abstract interface class AuthLocalDataSource {
  Future<AdminEntity?> getAdminsCachedData();

  Future<void> insertAdminsData(AdminEntity adminEntity);

  Future<int> clearAdminData();
}
