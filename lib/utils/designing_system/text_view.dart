import 'package:aksessuar_emp_admin/utils/designing_system/google_font.dart';
import 'package:flutter/material.dart';

class TextView extends StatelessWidget {
  const TextView({
    super.key,
    required this.text,
    this.textSize,
    this.textColor,
    this.textOverflow,
    this.maxLines,
    this.textAlign,
    this.fontWeight,
  });

  final String text;
  final double? textSize;
  final TextOverflow? textOverflow;
  final int? maxLines;
  final Color? textColor;
  final TextAlign? textAlign;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) => Text(
        text,
        overflow: textOverflow,
        maxLines: maxLines,
        style: googleFontStyle(
          fontSize: textSize,
          fontColor: textColor,
          fontWeight: fontWeight,
        ),
        textAlign: textAlign,
      );
}
