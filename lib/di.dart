import 'package:aksessuar_emp_admin/core/hive/hive_database.dart';
import 'package:aksessuar_emp_admin/core/service/shared_storage_service.dart';
import 'package:aksessuar_emp_admin/feature/auth/data/local/entity/admin_entity.dart';
import 'package:aksessuar_emp_admin/feature/auth/data/local/source/auth_local_data_source.dart';
import 'package:aksessuar_emp_admin/feature/auth/data/local/source/auth_local_data_source_impl.dart';
import 'package:aksessuar_emp_admin/feature/auth/data/remote/source/auth_remote_data_source.dart';
import 'package:aksessuar_emp_admin/feature/auth/data/remote/source/auth_remote_data_source_impl.dart';
import 'package:aksessuar_emp_admin/feature/auth/data/repository/auth_repository_impl.dart';
import 'package:aksessuar_emp_admin/feature/auth/domain/repository/auth_repository.dart';
import 'package:aksessuar_emp_admin/feature/auth/domain/use_case/get_admin_data_use_case.dart';
import 'package:aksessuar_emp_admin/feature/auth/domain/use_case/sync_admin_data_use_case.dart';
import 'package:aksessuar_emp_admin/feature/auth/presentation/bloc/login_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

final GetIt getIt = GetIt.instance;

Future<void> setupDependencies() async {
  getIt
    ..registerSingletonAsync<Box<AdminEntity>>(
      () async => await HiveDatabase.getAdminBox(),
      dispose: (box) {
        box.close();
      },
    )
    ..registerSingleton<FirebaseFirestore>(FirebaseFirestore.instance)
    ..registerSingleton<HiveSharedStorageService>(HiveSharedStorageService());
}

Future<void> authModule() async {
  getIt
    ..registerSingleton<AuthLocalDataSource>(
        AuthLocalDataSourceImpl(adminBox: await getIt.getAsync<Box<AdminEntity>>()))
    ..registerLazySingleton<AuthRemoteDataSource>(
        () => AuthRemoteDataSourceImpl(fireStore: getIt<FirebaseFirestore>()))
    ..registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(
          remoteDataSource: getIt<AuthRemoteDataSource>(),
          localDataSource: getIt<AuthLocalDataSource>(),
        ))
    ..registerFactory<SyncAdminDataUseCase>(
        () => SyncAdminDataUseCase(repository: getIt<AuthRepository>()))
    ..registerFactory<GetAdminDataUseCase>(
        () => GetAdminDataUseCase(repository: getIt<AuthRepository>()))
    ..registerFactory<LoginBloc>(() => LoginBloc(
          getAdminDataUseCase: getIt<GetAdminDataUseCase>(),
          syncAdminDataUseCase: getIt<SyncAdminDataUseCase>(),
        ));
}
