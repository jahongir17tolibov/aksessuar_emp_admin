import 'package:aksessuar_emp_admin/core/hive/hive_shared_storage_service.dart';
import 'package:aksessuar_emp_admin/feature/home/data/remote/source/home_remote_data_source.dart';
import 'package:aksessuar_emp_admin/feature/home/data/repository/mapper/home_mapper.dart';
import 'package:aksessuar_emp_admin/feature/home/domain/model/users_order_model.dart';
import 'package:aksessuar_emp_admin/feature/home/domain/repository/home_repository.dart';
import 'package:aksessuar_emp_admin/utils/constants.dart';

class HomeRepositoryImpl implements HomeRepository {
  HomeRepositoryImpl({
    required HomeRemoteDataSource remoteDataSource,
    required HiveSharedStorageService sharedStorage,
  })  : _remoteDataSource = remoteDataSource,
        _sharedStorage = sharedStorage;

  final HomeRemoteDataSource _remoteDataSource;
  final HiveSharedStorageService _sharedStorage;

  @override
  Stream<List<UsersOrderModel>> getUsersOrderDataReactive() async* {
    try {
      yield* _remoteDataSource
          .getUsersOrderData()
          .map((snapshot) => snapshot.map((data) => data.toUsersOrderModel()).toList());
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> addNewTestData({required UsersOrderModel usersOrderModel}) async {
    try {
      await _remoteDataSource.addRandomTestData(usersOrderModel.toUsersDtoModel());
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> signOutFromFirebase() async {
    try {
      await _remoteDataSource.signOut().whenComplete(() async {
        await _sharedStorage.deleteString(
          boxName: HiveConstants.userStorageBox,
          key: HiveConstants.userUIdKey,
        );
      });
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> deleteTestData({required String id}) async {
    try {
      return _remoteDataSource.deleteTestData(id);
    } catch (e) {
      throw Exception(e);
    }
  }
}
