import 'package:aksessuar_emp_admin/utils/designing_system/size_util.dart';
import 'package:aksessuar_emp_admin/utils/designing_system/text_view.dart';
import 'package:flutter/material.dart';

class ManageProductsScreen extends StatefulWidget {
  const ManageProductsScreen({super.key});

  static const String routeName = '/manage_products';

  @override
  State<ManageProductsScreen> createState() => _ManageProductsScreenState();
}

class _ManageProductsScreenState extends State<ManageProductsScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextView(
        text: 'Manage Products screen',
        textSize: 24.textSize(context),
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
