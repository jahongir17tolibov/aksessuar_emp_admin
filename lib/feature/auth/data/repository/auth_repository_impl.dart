import 'package:aksessuar_emp_admin/core/hive/hive_shared_storage_service.dart';
import 'package:aksessuar_emp_admin/feature/auth/data/remote/source/auth_remote_data_source.dart';
import 'package:aksessuar_emp_admin/feature/auth/data/remote/util/auth_result.dart';
import 'package:aksessuar_emp_admin/feature/auth/data/repository/mapper/auth_mapper.dart';
import 'package:aksessuar_emp_admin/feature/auth/domain/model/user_model.dart';
import 'package:aksessuar_emp_admin/feature/auth/domain/repository/auth_repository.dart';
import 'package:aksessuar_emp_admin/utils/constants.dart';
import 'package:flutter/cupertino.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({
    required AuthRemoteDataSource remoteDataSource,
    required HiveSharedStorageService hiveSharedStorageService,
  })  : _remoteDataSource = remoteDataSource,
        _sharedStorage = hiveSharedStorageService;

  final AuthRemoteDataSource _remoteDataSource;
  final HiveSharedStorageService _sharedStorage;

  @override
  Future<AuthResult<UserModel>> registerUserByEmail({
    required String email,
    required String password,
  }) async =>
      await _remoteDataSource.createUserByEmail(email, password).then((result) {
        UserModel? userModel = result.data?.toUserModel();
        return AuthResult(data: userModel, errorMessage: result.errorMessage);
      });

  @override
  Future<AuthResult<UserModel>> loginWithEmail({
    required String email,
    required String password,
  }) async =>
      await _remoteDataSource.signInUserByEmail(email, password).then((result) {
        UserModel? userModel = result.data?.toUserModel();
        return AuthResult(data: userModel, errorMessage: result.errorMessage);
      });

  @override
  Future<AuthResult<UserModel>> signInWithGoogle() async =>
      await _remoteDataSource.signInByGoogle().then((result) {
        UserModel? userModel = result.data?.toUserModel();
        return AuthResult(data: userModel, errorMessage: result.errorMessage);
      });

  @override
  Future<UserModel?> getFirebaseUser() async {
    try {
      return await _remoteDataSource.getSignedUser().then((dto) => dto?.toUserModel());
    } catch (e, st) {
      debugPrintStack(stackTrace: st);
      throw Exception(e);
    }
  }

  @override
  Future<void> saveUserUId({required uid}) async {
    try {
      await _sharedStorage.saveString(
        boxName: HiveConstants.userStorageBox,
        key: HiveConstants.userUIdKey,
        value: uid,
      );
    } catch (e, st) {
      debugPrintStack(stackTrace: st);
      throw Exception(e);
    }
  }

  @override
  Future<String?> getUserUId() async {
    try {
      final savedUserUId = await _sharedStorage.getString(
        boxName: HiveConstants.userStorageBox,
        key: HiveConstants.userUIdKey,
      );
      return savedUserUId.isNotEmpty ? savedUserUId : null;
    } catch (e, st) {
      debugPrintStack(stackTrace: st);
      throw Exception(e);
    }
  }
}
