import 'package:aksessuar_emp_admin/utils/designing_system/components/google_font.dart';
import 'package:aksessuar_emp_admin/utils/designing_system/components/size_util.dart';
import 'package:flutter/material.dart';

class RichTextForItem extends StatelessWidget {
  const RichTextForItem({super.key, required this.startText, required this.endText});

  final String startText;
  final String endText;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: "$startText: ",
        style: googleFontStyle(
          fontColor: Theme.of(context).colorScheme.onPrimaryContainer,
          fontSize: 20.textSize(context),
          fontWeight: FontWeight.bold,
        ),
        children: <TextSpan>[
          TextSpan(
            text: endText,
            style: googleFontStyle(
              fontColor: Theme.of(context).colorScheme.onPrimaryContainer,
              fontSize: 20.textSize(context),
            ),
          )
        ],
      ),
    );
  }
}
