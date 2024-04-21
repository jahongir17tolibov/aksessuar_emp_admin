import 'package:aksessuar_emp_admin/utils/designing_system/components/google_font.dart';
import 'package:aksessuar_emp_admin/utils/designing_system/components/size_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EmailInputTextField extends StatelessWidget {
  const EmailInputTextField({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.onEditingComplete,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final VoidCallback onEditingComplete;

  @override
  Widget build(BuildContext context) => CupertinoTextField(
        controller: controller,
        placeholder: 'enter email',
        keyboardType: TextInputType.emailAddress,
        focusNode: focusNode,
        onEditingComplete: onEditingComplete,
        textInputAction: TextInputAction.next,
        maxLines: 1,
        cursorOpacityAnimates: true,
        cursorColor: Theme.of(context).colorScheme.primaryContainer,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.fromBorderSide(
            BorderSide(color: Theme.of(context).colorScheme.primaryContainer),
          ),
        ),
        prefix: Padding(
          padding: const EdgeInsets.only(left: 6.0),
          child: Icon(Icons.email_outlined, color: Theme.of(context).colorScheme.primary),
        ),
        style: googleFontStyle(
          fontSize: 22.textSize(context),
          fontColor: Theme.of(context).colorScheme.onBackground,
        ),
      );
}
