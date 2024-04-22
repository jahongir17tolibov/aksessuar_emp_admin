import 'package:aksessuar_emp_admin/feature/auth/domain/model/user_model.dart';
import 'package:aksessuar_emp_admin/feature/auth/presentation/login/login_screen.dart';
import 'package:aksessuar_emp_admin/feature/home/domain/model/users_order_model.dart';
import 'package:aksessuar_emp_admin/feature/home/presentation/bloc/home_bloc.dart';
import 'package:aksessuar_emp_admin/feature/home/presentation/widget/rich_text_for_item.dart';
import 'package:aksessuar_emp_admin/feature/home/presentation/widget/sign_out_cupertino_alert_dialog.dart';
import 'package:aksessuar_emp_admin/utils/designing_system/components/error_widget.dart';
import 'package:aksessuar_emp_admin/utils/designing_system/components/show_snack_bar.dart';
import 'package:aksessuar_emp_admin/utils/designing_system/components/size_util.dart';
import 'package:aksessuar_emp_admin/utils/designing_system/components/text_view.dart';
import 'package:aksessuar_emp_admin/utils/designing_system/generate_random_color.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widget/users_order_list_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const String routeName = '/home';

  static Future<void> open(BuildContext context) async {
    await Navigator.of(context).pushNamedAndRemoveUntil(routeName, (route) => false);
  }

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late UserModel? _userModel;
  double _amountCount = 0;

  @override
  void initState() {
    Future.microtask(() {
      context.read<HomeBloc>().add(HomeOnGetUsersOrderListEvent());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: TextView(text: 'Home', textColor: Theme.of(context).colorScheme.onSurface),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              showCupertinoDialog(
                context: context,
                barrierDismissible: true,
                builder: (_) => SignOutCupertinoAlertDialog(
                  userModel: _userModel,
                  onClickAccept: () {
                    context.read<HomeBloc>().add(HomeOnClickAcceptToSignOutEvent());
                    Navigator.of(context).pop();
                  },
                ),
              );
            },
            icon: Icon(
              Icons.exit_to_app_outlined,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          )
        ],
      ),
      body: BlocConsumer<HomeBloc, HomeState>(
        buildWhen: (previousState, currentState) =>
            currentState.status != HomeStatus.showMessage ||
            currentState.status != HomeStatus.onSignOut,
        builder: (context, state) {
          if (state.status == HomeStatus.onSuccess) {
            _userModel = state.userModel;
            _countAmounts(state.usersOrderList!);
            return CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  pinned: false,
                  snap: true,
                  floating: true,
                  expandedHeight:
                      (orientation == Orientation.portrait) ? 0.4.screenHeight(context) : null,
                  flexibleSpace: (orientation == Orientation.portrait)
                      ? FlexibleSpaceBar(
                          background: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                width: 0.32.screenWidth(context),
                                height: 0.32.screenHeight(context),
                                child: PieChart(
                                  swapAnimationDuration: const Duration(milliseconds: 1000),
                                  PieChartData(
                                    centerSpaceRadius: 80,
                                    sections: [
                                      ...List.generate(state.usersOrderList!.length, (index) {
                                        final calculateAmountPerc =
                                            (state.usersOrderList![index].amount! * 100) /
                                                _amountCount;
                                        return PieChartSectionData(
                                          color: generateRandomColor(),
                                          showTitle: true,
                                          title:
                                              '${double.parse(calculateAmountPerc.toStringAsFixed(1))}%',
                                        );
                                      }),
                                    ],
                                  ),
                                ),
                              ),
                              RichTextForItem(
                                startText: 'all amounts',
                                endText: "${_amountCount.toInt().toString()}\$",
                              ),
                            ],
                          ),
                        )
                      : null,
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    childCount: state.usersOrderList!.length,
                    (context, index) {
                      final usersOrder = state.usersOrderList![index];
                      return UsersOrderListItem(
                        usersOrderModel: usersOrder,
                        onClickDeleteBtn: () {
                          context
                              .read<HomeBloc>()
                              .add(HomeOnDeleteTestDataEvent(usersOrder.userUid!));
                        },
                      );
                    },
                  ),
                )
              ],
            );
          } else if (state.status == HomeStatus.onLoading) {
            return Center(
              child: CupertinoActivityIndicator(
                color: Theme.of(context).colorScheme.tertiaryContainer,
              ),
            );
          } else if (state.status == HomeStatus.onEmpty) {
            return Center(
              child: TextView(
                text: 'Data is empty',
                textSize: 20.textSize(context),
                fontWeight: FontWeight.bold,
              ),
            );
          } else if (state.status == HomeStatus.onError) {
            return OnErrorWidget(errorText: state.error!);
          }
          return Container();
        },
        listenWhen: (previousState, currentState) =>
            currentState.status == HomeStatus.showMessage ||
            currentState.status == HomeStatus.onSignOut,
        listener: (context, state) async {
          if (state.status == HomeStatus.showMessage) {
            showSnackBar(state.messageForSnackBar!, context);
          } else if (state.status == HomeStatus.onSignOut) {
            await LoginScreen.open(context);
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<HomeBloc>().add(HomeOnAddNewRandomTestDataEvent());
        },
        backgroundColor: Theme.of(context).colorScheme.primary,
        tooltip: 'Add new test data',
        child: Icon(Icons.add, color: Theme.of(context).colorScheme.onPrimary),
      ),
    );
  }

  void _countAmounts(List<UsersOrderModel> usersOrderData) {
    _amountCount = 0;
    for (var data in usersOrderData) {
      _amountCount += data.amount!;
    }
  }
}
