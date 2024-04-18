import 'package:aksessuar_emp_admin/feature/auth/presentation/login_screen.dart';
import 'package:aksessuar_emp_admin/feature/home/home_screen.dart';
import 'package:aksessuar_emp_admin/feature/manage_employees/manage_employees_screen.dart';
import 'package:aksessuar_emp_admin/feature/manage_products/manage_products_screen.dart';
import 'package:aksessuar_emp_admin/feature/settings/settings_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RouterNavigation {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case LoginScreen.routeName:
        return _materialNavigate(const LoginScreen());

      case HomeScreen.routeName:
        return _materialNavigate(const HomeScreen());

      case ManageEmployeeScreen.routeName:
        return _materialNavigate(const ManageEmployeeScreen());

      case ManageProductsScreen.routeName:
        return _materialNavigate(const ManageProductsScreen());

      case SettingsScreen.routeName:
        return _cupertinoNavigate(const SettingsScreen());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }

  static Route<dynamic> _materialNavigate(Widget screen) =>
      MaterialPageRoute(builder: (_) => screen);

  static Route<dynamic> _cupertinoNavigate(Widget screen) =>
      CupertinoPageRoute(builder: (_) => screen);
}
