import 'package:aksessuar_emp_admin/utils/designing_system/components/size_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'google_font.dart';

class PasswordInputTextField extends StatelessWidget {
  const PasswordInputTextField({
    super.key,
    required this.controller,
    required this.focusNode,
    this.onEditingComplete,
    this.placeHolderText,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final VoidCallback? onEditingComplete;
  final String? placeHolderText;

  @override
  Widget build(BuildContext context) => CupertinoTextField(
        controller: controller,
        placeholder: placeHolderText ?? 'enter password',
        obscureText: true,
        focusNode: focusNode,
        keyboardType: TextInputType.visiblePassword,
        textInputAction: TextInputAction.done,
        maxLines: 1,
        cursorOpacityAnimates: true,
        onEditingComplete: onEditingComplete,
        cursorColor: Theme.of(context).colorScheme.primaryContainer,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.fromBorderSide(
            BorderSide(color: Theme.of(context).colorScheme.primaryContainer),
          ),
        ),
        prefix: Padding(
          padding: const EdgeInsets.only(left: 6.0),
          child: Icon(Icons.key_outlined, color: Theme.of(context).colorScheme.primary),
        ),
        style: googleFontStyle(
          fontSize: 22.textSize(context),
          fontColor: Theme.of(context).colorScheme.onBackground,
        ),
      );
}
