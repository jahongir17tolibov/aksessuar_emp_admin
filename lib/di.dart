import 'package:aksessuar_emp_admin/core/hive/hive_shared_storage_service.dart';
import 'package:aksessuar_emp_admin/feature/auth/data/remote/source/auth_remote_data_source.dart';
import 'package:aksessuar_emp_admin/feature/auth/data/remote/source/auth_remote_data_source_impl.dart';
import 'package:aksessuar_emp_admin/feature/auth/data/repository/auth_repository_impl.dart';
import 'package:aksessuar_emp_admin/feature/auth/domain/repository/auth_repository.dart';
import 'package:aksessuar_emp_admin/feature/auth/domain/use_case/get_firebase_user_use_case.dart';
import 'package:aksessuar_emp_admin/feature/auth/domain/use_case/get_user_uid_use_case.dart';
import 'package:aksessuar_emp_admin/feature/auth/domain/use_case/login_user_by_email_use_case.dart';
import 'package:aksessuar_emp_admin/feature/auth/domain/use_case/register_user_by_email_use_case.dart';
import 'package:aksessuar_emp_admin/feature/auth/domain/use_case/save_user_uid_use_case.dart';
import 'package:aksessuar_emp_admin/feature/auth/domain/use_case/sign_in_with_google_use_case.dart';
import 'package:aksessuar_emp_admin/feature/auth/presentation/login/bloc/login_bloc.dart';
import 'package:aksessuar_emp_admin/feature/auth/presentation/register/bloc/register_bloc.dart';
import 'package:aksessuar_emp_admin/feature/home/data/remote/source/home_remote_data_source.dart';
import 'package:aksessuar_emp_admin/feature/home/data/remote/source/home_remote_data_source_impl.dart';
import 'package:aksessuar_emp_admin/feature/home/data/repository/home_repository_impl.dart';
import 'package:aksessuar_emp_admin/feature/home/domain/repository/home_repository.dart';
import 'package:aksessuar_emp_admin/feature/home/domain/use_case/add_new_test_data_use_case.dart';
import 'package:aksessuar_emp_admin/feature/home/domain/use_case/delete_test_data_use_case.dart';
import 'package:aksessuar_emp_admin/feature/home/domain/use_case/get_users_order_data_reactive_use_case.dart';
import 'package:aksessuar_emp_admin/feature/home/domain/use_case/sign_out_use_case.dart';
import 'package:aksessuar_emp_admin/feature/home/presentation/bloc/home_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;

Future<void> setupDependencies() async {
  getIt

    /// main
    ..registerSingleton<FirebaseFirestore>(FirebaseFirestore.instance)
    ..registerSingleton<FirebaseAuth>(FirebaseAuth.instance)
    ..registerSingleton<HiveSharedStorageService>(HiveSharedStorageService())

    /// auth module
    ..registerLazySingleton<AuthRemoteDataSource>(
        () => AuthRemoteDataSourceImpl(firebaseAuth: getIt<FirebaseAuth>()))
    ..registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(
          remoteDataSource: getIt<AuthRemoteDataSource>(),
          hiveSharedStorageService: getIt<HiveSharedStorageService>(),
        ))
    ..registerFactory<RegisterUserByEmailUseCase>(
        () => RegisterUserByEmailUseCase(repository: getIt<AuthRepository>()))
    ..registerFactory<LoginUserByEmailUseCase>(
        () => LoginUserByEmailUseCase(repository: getIt<AuthRepository>()))
    ..registerFactory<SignInWithGoogleUseCase>(
        () => SignInWithGoogleUseCase(repository: getIt<AuthRepository>()))
    ..registerFactory<GetFirebaseUserUseCase>(
        () => GetFirebaseUserUseCase(repository: getIt<AuthRepository>()))
    ..registerFactory<SaveUserUIdUseCase>(
        () => SaveUserUIdUseCase(repository: getIt<AuthRepository>()))
    ..registerFactory<GetUserUIdUseCase>(
        () => GetUserUIdUseCase(repository: getIt<AuthRepository>()))
    ..registerFactory<LoginBloc>(() => LoginBloc(
          loginUserByEmailUseCase: getIt<LoginUserByEmailUseCase>(),
          signInWithGoogleUseCase: getIt<SignInWithGoogleUseCase>(),
          saveUserUIdUseCase: getIt<SaveUserUIdUseCase>(),
          getUserUIdUseCase: getIt<GetUserUIdUseCase>(),
        ))
    ..registerFactory<RegisterBloc>(() => RegisterBloc(
          registerUserByEmailUseCase: getIt<RegisterUserByEmailUseCase>(),
          saveUserUIdUseCase: getIt<SaveUserUIdUseCase>(),
          signInWithGoogleUseCase: getIt<SignInWithGoogleUseCase>(),
        ))

    /// home module
    ..registerLazySingleton<HomeRemoteDataSource>(() => HomeRemoteDataSourceImpl(
          firestore: getIt<FirebaseFirestore>(),
          firebaseAuth: getIt<FirebaseAuth>(),
        ))
    ..registerLazySingleton<HomeRepository>(() => HomeRepositoryImpl(
          remoteDataSource: getIt<HomeRemoteDataSource>(),
          sharedStorage: getIt<HiveSharedStorageService>(),
        ))
    ..registerFactory<GetUsersOrderDataReactiveUseCase>(
        () => GetUsersOrderDataReactiveUseCase(repository: getIt<HomeRepository>()))
    ..registerFactory<AddNewTestDataUseCase>(
        () => AddNewTestDataUseCase(repository: getIt<HomeRepository>()))
    ..registerFactory<DeleteTestDataUseCase>(
        () => DeleteTestDataUseCase(repository: getIt<HomeRepository>()))
    ..registerFactory<SignOutUseCase>(() => SignOutUseCase(repository: getIt<HomeRepository>()))
    ..registerFactory<HomeBloc>(() => HomeBloc(
          getUsersOrderDataReactiveUseCase: getIt<GetUsersOrderDataReactiveUseCase>(),
          addNewTestDataUseCase: getIt<AddNewTestDataUseCase>(),
          signOutUseCase: getIt<SignOutUseCase>(),
          getFirebaseUserUseCase: getIt<GetFirebaseUserUseCase>(),
          deleteTestDataUseCase: getIt<DeleteTestDataUseCase>(),
        ));
}
