import 'dart:async';

import 'package:aksessuar_emp_admin/di.dart';
import 'package:aksessuar_emp_admin/feature/auth/presentation/register/register_screen.dart';
import 'package:aksessuar_emp_admin/feature/home/presentation/home_screen.dart';
import 'package:aksessuar_emp_admin/utils/constants.dart';
import 'package:aksessuar_emp_admin/utils/designing_system/components/auth_button.dart';
import 'package:aksessuar_emp_admin/utils/designing_system/components/email_cupertino_textfield.dart';
import 'package:aksessuar_emp_admin/utils/designing_system/components/google_button.dart';
import 'package:aksessuar_emp_admin/utils/designing_system/components/google_font.dart';
import 'package:aksessuar_emp_admin/utils/designing_system/components/password_cupertino_textfield.dart';
import 'package:aksessuar_emp_admin/utils/designing_system/components/show_snack_bar.dart';
import 'package:aksessuar_emp_admin/utils/designing_system/components/size_util.dart';
import 'package:aksessuar_emp_admin/utils/designing_system/components/error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/login_bloc.dart';
import 'widget/auth_linear_gradient_bckg.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const String routeName = '/login';

  static Future<void> open(BuildContext context) async {
    await Navigator.of(context).pushNamedAndRemoveUntil(routeName, (route) => false);
  }

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController _emailEditingController;
  late TextEditingController _passwordEditingController;
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocProvider<LoginBloc>(
        create: (_) => getIt<LoginBloc>()..add(LoginOnAuthenticationEvent()),
        child: BlocConsumer<LoginBloc, LoginState>(
          buildWhen: (previousState, currentState) =>
              currentState.status != LoginStatus.showMessage ||
              currentState.status != LoginStatus.isAuthenticated,
          builder: (context, state) {
            _emailEditingController = context.watch<LoginBloc>().emailEditingController;
            _passwordEditingController = context.watch<LoginBloc>().passwordEditingController;
            if (state.status == LoginStatus.initial) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    width: 1.screenWidth(context),
                    height: 0.3.screenHeight(context),
                    decoration: BoxDecoration(
                      gradient: linearGradientBckg(context),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                    child: Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(1.screenHeight(context)),
                        child: Image.asset(
                          ImageConstants.adminDefaultImg,
                          width: 135,
                          height: 135,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: 0.1.screenHeight(context)),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 0.1.screenWidth(context)),
                          child: EmailInputTextField(
                            controller: _emailEditingController,
                            focusNode: _emailFocusNode,
                            onEditingComplete: () {
                              FocusScope.of(context).requestFocus(_passwordFocusNode);
                            },
                          ),
                        ),
                        SizedBox(height: 0.03.screenHeight(context)),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 0.1.screenWidth(context)),
                          child: PasswordInputTextField(
                            controller: _passwordEditingController,
                            focusNode: _passwordFocusNode,
                          ),
                        ),
                        SizedBox(height: 0.06.screenHeight(context)),
                        AuthButton(
                          onPressed: _emailEditingController.text.isNotEmpty &&
                                  _passwordEditingController.text.isNotEmpty
                              ? () {
                                  if (FocusScope.of(context).hasFocus) {
                                    FocusScope.of(context).unfocus();
                                  }
                                  context.read<LoginBloc>().add(LoginOnClickLoginBtnEvent());
                                }
                              : null,
                          text: 'Login',
                          isLoading: state.isLoading,
                        ),
                        GoogleSignInButton(onPressed: () {
                          if (FocusScope.of(context).hasFocus) FocusScope.of(context).unfocus();
                          context.read<LoginBloc>().add(LoginOnClickGoogleBtnEvent());
                        }),
                        TextButton(
                          onPressed: () async {
                            await RegisterScreen.open(context);
                          },
                          child: RichText(
                            text: TextSpan(
                              text: "Don't registered yet?, ",
                              style: googleFontStyle(
                                fontColor: Theme.of(context).colorScheme.onBackground,
                                fontSize: 16.textSize(context),
                                fontStyle: FontStyle.italic,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'sign up!',
                                  style: googleFontStyle(
                                    fontColor: Theme.of(context).colorScheme.primary,
                                    fontSize: 16.textSize(context),
                                    fontStyle: FontStyle.italic,
                                  ),
                                )
                              ],
                            ),
                          ),
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
              currentState.status == LoginStatus.isAuthenticated,
          listener: (context, state) async {
            if (state.status == LoginStatus.showMessage) {
              showSnackBar(state.messageForSnackBar!, context);
            } else if (state.status == LoginStatus.isAuthenticated) {
              await HomeScreen.open(context);
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }
}
