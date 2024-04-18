import 'package:aksessuar_emp_admin/utils/designing_system/size_util.dart';
import 'package:aksessuar_emp_admin/utils/designing_system/text_view.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  static const String routeName = '/settings';

  static Future<void> open(BuildContext context) async {
    await Navigator.of(context).pushNamed(routeName);
  }

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextView(
        text: 'Settings screen',
        textSize: 24.textSize(context),
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
