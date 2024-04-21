import 'package:aksessuar_emp_admin/utils/constants.dart';
import 'package:aksessuar_emp_admin/utils/designing_system/components/size_util.dart';
import 'package:aksessuar_emp_admin/utils/designing_system/components/text_view.dart';
import 'package:flutter/material.dart';

import 'scale_on_press_button.dart';

class GoogleSignInButton extends StatelessWidget {
  const GoogleSignInButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 0.1.screenWidth(context)),
        child: ScaleOnPress(
          onTap: null,
          child: MaterialButton(
            onPressed: onPressed,
            minWidth: 1.screenWidth(context),
            color: Theme.of(context).colorScheme.surface,
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
              side: BorderSide(color: Theme.of(context).colorScheme.primary),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(ImageConstants.googleLogoImg, width: 20, height: 20, fit: BoxFit.cover),
                const SizedBox(width: 10),
                TextView(
                  text: "Google",
                  textSize: 18.textSize(context),
                  textColor: Theme.of(context).colorScheme.onBackground,
                ),
              ],
            ),
          ),
        ),
      );
}
