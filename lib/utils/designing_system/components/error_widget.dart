import 'package:aksessuar_emp_admin/utils/designing_system/components/size_util.dart';
import 'package:aksessuar_emp_admin/utils/designing_system/components/text_view.dart';
import 'package:flutter/material.dart';

class OnErrorWidget extends StatelessWidget {
  const OnErrorWidget({super.key, required this.errorText});

  final String errorText;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: TextView(
          text: errorText,
          maxLines: 5,
          textColor: Theme.of(context).colorScheme.error,
          textOverflow: TextOverflow.ellipsis,
          textSize: 20.textSize(context),
        ),
      ),
    );
  }
}
