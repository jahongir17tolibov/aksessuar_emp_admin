import 'package:aksessuar_emp_admin/utils/designing_system/size_util.dart';
import 'package:aksessuar_emp_admin/utils/designing_system/text_view.dart';
import 'package:flutter/material.dart';

class ManageEmployeeScreen extends StatefulWidget {
  const ManageEmployeeScreen({super.key});

  static const String routeName = '/manage_employees';

  @override
  State<ManageEmployeeScreen> createState() => _ManageEmployeeScreenState();
}

class _ManageEmployeeScreenState extends State<ManageEmployeeScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextView(
        text: 'Manage emplyee screen',
        textSize: 24.textSize(context),
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
