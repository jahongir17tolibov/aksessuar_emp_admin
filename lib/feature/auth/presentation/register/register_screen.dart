import 'package:aksessuar_emp_admin/di.dart';
import 'package:aksessuar_emp_admin/feature/auth/presentation/login/login_screen.dart';
import 'package:aksessuar_emp_admin/feature/auth/presentation/register/bloc/register_bloc.dart';
import 'package:aksessuar_emp_admin/feature/home/presentation/home_screen.dart';
import 'package:aksessuar_emp_admin/utils/designing_system/components/auth_button.dart';
import 'package:aksessuar_emp_admin/utils/designing_system/components/email_cupertino_textfield.dart';
import 'package:aksessuar_emp_admin/utils/designing_system/components/google_button.dart';
import 'package:aksessuar_emp_admin/utils/designing_system/components/google_font.dart';
import 'package:aksessuar_emp_admin/utils/designing_system/components/password_cupertino_textfield.dart';
import 'package:aksessuar_emp_admin/utils/designing_system/components/show_snack_bar.dart';
import 'package:aksessuar_emp_admin/utils/designing_system/components/size_util.dart';
import 'package:aksessuar_emp_admin/utils/designing_system/components/text_view.dart';
import 'package:aksessuar_emp_admin/utils/designing_system/components/error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  static const String routeName = '/register';

  static Future<void> open(BuildContext context) async {
    await Navigator.of(context).pushNamed(routeName);
  }

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late TextEditingController _emailEditingController;
  late TextEditingController _passwordEditingController;
  late TextEditingController _reEnterPassEditingController;
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _reEnterPassFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocProvider<RegisterBloc>(
        create: (_) => getIt<RegisterBloc>(),
        child: BlocConsumer<RegisterBloc, RegisterState>(
          buildWhen: (previousState, currentState) =>
              currentState.status != RegisterStatus.showMessage ||
              currentState.status != RegisterStatus.isAuthenticated,
          builder: (context, state) {
            _emailEditingController = context.watch<RegisterBloc>().emailEditingController;
            _passwordEditingController = context.watch<RegisterBloc>().passwordEditingController;
            _reEnterPassEditingController =
                context.watch<RegisterBloc>().reEnterPasswordEditingController;
            if (state.status == RegisterStatus.initial) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    width: 1.screenWidth(context),
                    height: 0.25.screenHeight(context),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.tertiaryContainer,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                    child: Center(
                      child: TextView(
                        text: "Register as new user",
                        textSize: 36.textSize(context),
                        fontWeight: FontWeight.bold,
                        textColor: Theme.of(context).colorScheme.onTertiaryContainer,
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
                            onEditingComplete: () {
                              FocusScope.of(context).requestFocus(_reEnterPassFocusNode);
                            },
                          ),
                        ),
                        SizedBox(height: 0.01.screenHeight(context)),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 0.1.screenWidth(context)),
                          child: PasswordInputTextField(
                            controller: _reEnterPassEditingController,
                            focusNode: _reEnterPassFocusNode,
                            placeHolderText: 'reenter password',
                            onEditingComplete: () {
                              FocusScope.of(context).unfocus();
                            },
                          ),
                        ),
                        SizedBox(height: 0.06.screenHeight(context)),
                        AuthButton(
                          onPressed: _emailEditingController.text.isNotEmpty &&
                                  _passwordEditingController.text.isNotEmpty &&
                                  _reEnterPassEditingController.text.isNotEmpty
                              ? () {
                                  if (FocusScope.of(context).hasFocus) {
                                    FocusScope.of(context).unfocus();
                                  }
                                  context
                                      .read<RegisterBloc>()
                                      .add(RegisterOnClickRegisterBtnEvent());
                                }
                              : null,
                          text: 'Register',
                          isLoading: state.isLoading,
                        ),
                        GoogleSignInButton(onPressed: () {
                          if (FocusScope.of(context).hasFocus) FocusScope.of(context).unfocus();
                          context.read<RegisterBloc>().add(RegisterOnClickGoogleBtnEvent());
                        }),
                        TextButton(
                          onPressed: () async {
                            await LoginScreen.open(context);
                          },
                          child: RichText(
                            text: TextSpan(
                              text: "Already registered, ",
                              style: googleFontStyle(
                                fontColor: Theme.of(context).colorScheme.onBackground,
                                fontSize: 16.textSize(context),
                                fontStyle: FontStyle.italic,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'sign in!',
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
            } else if (state.status == RegisterStatus.onError) {
              return OnErrorWidget(errorText: state.error!);
            }
            return Container();
          },
          listenWhen: (previousState, currentState) =>
              currentState.status == RegisterStatus.showMessage ||
              currentState.status == RegisterStatus.isAuthenticated,
          listener: (context, state) async {
            if (state.status == RegisterStatus.showMessage) {
              showSnackBar(state.messageForSnackBar!, context);
            } else if (state.status == RegisterStatus.isAuthenticated) {
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
