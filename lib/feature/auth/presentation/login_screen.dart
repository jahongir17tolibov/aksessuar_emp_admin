import 'dart:async';

import 'package:aksessuar_emp_admin/di.dart';
import 'package:aksessuar_emp_admin/feature/auth/presentation/bloc/login_bloc.dart';
import 'package:aksessuar_emp_admin/feature/auth/presentation/widget/auth_linear_gradient_bckg.dart';
import 'package:aksessuar_emp_admin/utils/constants.dart';
import 'package:aksessuar_emp_admin/utils/designing_system/error_widget.dart';
import 'package:aksessuar_emp_admin/utils/designing_system/size_util.dart';
import 'package:aksessuar_emp_admin/utils/designing_system/text_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const String routeName = '/login';

  static Future<void> open(BuildContext context) async {
    await Navigator.of(context).pushNamed(routeName);
  }

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<LoginBloc>(
        create: (_) => getIt<LoginBloc>()..add(LoginOnGetAdminDataEvent()),
        child: BlocConsumer<LoginBloc, LoginState>(
          buildWhen: (previousState, currentState) =>
              currentState.status != LoginStatus.showMessage ||
              currentState.status != LoginStatus.isValid,
          builder: (context, state) {
            if (state.status == LoginStatus.initial) {
              return Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Container(
                    width: 1.screenWidth(context),
                    height: 0.36.screenHeight(context),
                    decoration: BoxDecoration(
                      gradient: linearGradientBckg(context),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                    child: Center(
                        child:
                            Image.asset(ImageConstants.adminDefaultImg, width: 200, height: 200)),
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        TextView(
                          text: state.isLoading! ? '...' : state.adminData!.login,
                          textSize: state.isLoading! ? 40.textSize(context) : 20.textSize(context),
                          textColor: Theme.of(context).colorScheme.onBackground,
                        ),
                        TextView(
                          text: state.isLoading! ? '...' : state.adminData!.password,
                          textSize: state.isLoading! ? 40.textSize(context) : 20.textSize(context),
                          textColor: Theme.of(context).colorScheme.primary,
                        ),
                        TextView(
                          text: state.isLoading! ? '...' : state.adminData!.registeredTime,
                          textSize: state.isLoading! ? 40.textSize(context) : 20.textSize(context),
                          textColor: Theme.of(context).colorScheme.secondary,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else if (state.status == LoginStatus.onError) {
              return OnErrorWidget(errorText: state.error!);
            }
            return Container();
          },
          listenWhen: (previousState, currentState) =>
              currentState.status == LoginStatus.showMessage ||
              currentState.status == LoginStatus.isValid,
          listener: (context, state) {},
        ),
      ),
    );
  }
}
