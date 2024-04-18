import 'package:aksessuar_emp_admin/feature/auth/data/local/entity/admin_entity.dart';
import 'package:aksessuar_emp_admin/feature/auth/data/local/source/auth_local_data_source.dart';
import 'package:hive/hive.dart';

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  AuthLocalDataSourceImpl({required Box<AdminEntity> adminBox}) : _adminBox = adminBox;

  final Box<AdminEntity> _adminBox;

  @override
  Future<AdminEntity?> getAdminsCachedData() async {
    try {
      return _adminBox.isNotEmpty ? _adminBox.values.single : null;
    } on HiveError catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> insertAdminsData(AdminEntity adminEntity) async {
    try {
      await _adminBox.put(adminEntity.id, adminEntity);
    } on HiveError catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<int> clearAdminData() async {
    try {
      return await _adminBox.clear();
    } on HiveError catch (e) {
      throw Exception(e);
    }
  }
}
