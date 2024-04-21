import 'package:aksessuar_emp_admin/core/hive/hive_database.dart';
import 'package:aksessuar_emp_admin/core/navigation/router.dart';
import 'package:aksessuar_emp_admin/di.dart';
import 'package:aksessuar_emp_admin/feature/home/presentation/bloc/home_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'feature/auth/presentation/login/login_screen.dart';
import 'firebase_options.dart';
import 'utils/designing_system/theme/theme.dart';

void main() async {
  final WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await HiveDatabase.initHiveFlutter();
  // dependency injection
  await setupDependencies();
  FlutterNativeSplash.remove();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeBloc>(create: (_) => getIt<HomeBloc>(), lazy: false),
      ],
      child: MaterialApp(
        onGenerateRoute: RouterNavigation.generateRoute,
        debugShowCheckedModeBanner: false,
        theme: appLightTheme,
        darkTheme: appDarkTheme,
        initialRoute: LoginScreen.routeName,
      ),
    );
  }
}
