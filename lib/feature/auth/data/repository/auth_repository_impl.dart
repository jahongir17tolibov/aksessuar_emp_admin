import 'package:aksessuar_emp_admin/feature/auth/data/local/source/auth_local_data_source.dart';
import 'package:aksessuar_emp_admin/feature/auth/data/mapper/auth_mapper.dart';
import 'package:aksessuar_emp_admin/feature/auth/data/remote/source/auth_remote_data_source.dart';
import 'package:aksessuar_emp_admin/feature/auth/domain/model/admin_model.dart';
import 'package:aksessuar_emp_admin/feature/auth/domain/repository/auth_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({
    required AuthRemoteDataSource remoteDataSource,
    required AuthLocalDataSource localDataSource,
  })  : _remoteDataSource = remoteDataSource,
        _localDataSource = localDataSource;

  final AuthRemoteDataSource _remoteDataSource;
  final AuthLocalDataSource _localDataSource;

  @override
  Future<AdminModel?> getAdminData() async {
    try {
      return await _localDataSource.getAdminsCachedData().then((entity) => entity?.toAdminModel());
    } catch (e, st) {
      debugPrintStack(stackTrace: st);
      throw Exception("get admin data: $e");
    }
  }

  @override
  Future<void> syncAdminData() async {
    try {
      final getAdminDataFromFirebase = await _remoteDataSource.getAdminAuthData().then((dto) {
        throwIf(dto == null, "Admin ma'lumotlari bazada yo'q");
        return dto!.toAdminEntity();
      });

      //save locally
      await _localDataSource.clearAdminData().whenComplete(() async {
        await _localDataSource.insertAdminsData(getAdminDataFromFirebase);
      });
    } catch (e, st) {
      debugPrintStack(stackTrace: st);
      throw Exception("syncAdminData: $e");
    }
  }
}
