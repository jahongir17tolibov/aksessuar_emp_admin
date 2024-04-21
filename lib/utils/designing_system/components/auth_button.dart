import 'package:aksessuar_emp_admin/utils/designing_system/components/size_util.dart';
import 'package:aksessuar_emp_admin/utils/designing_system/components/text_view.dart';
import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({
    super.key,
    this.onPressed,
    required this.text,
    required this.isLoading,
  });

  final VoidCallback? onPressed;
  final String text;
  final bool isLoading;

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 0.1.screenWidth(context)),
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 1.screenWidth(context),
          color: Theme.of(context).colorScheme.primary,
          disabledColor: Theme.of(context).colorScheme.outline,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextView(
                text: text,
                textSize: 18.textSize(context),
                textColor: Theme.of(context).colorScheme.onPrimary,
              ),
              const SizedBox(width: 10),
              Visibility(
                visible: isLoading,
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    color: Theme.of(context).colorScheme.onPrimary,
                    strokeWidth: 2,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
