import 'package:aksessuar_emp_admin/utils/designing_system/size_util.dart';
import 'package:aksessuar_emp_admin/utils/designing_system/text_view.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const String routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextView(
        text: 'Home screen',
        textSize: 24.textSize(context),
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
