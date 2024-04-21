import 'package:aksessuar_emp_admin/feature/auth/domain/model/user_model.dart';
import 'package:aksessuar_emp_admin/utils/constants.dart';
import 'package:aksessuar_emp_admin/utils/designing_system/components/cached_image_view.dart';
import 'package:aksessuar_emp_admin/utils/designing_system/components/size_util.dart';
import 'package:aksessuar_emp_admin/utils/designing_system/components/text_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SignOutCupertinoAlertDialog extends StatelessWidget {
  const SignOutCupertinoAlertDialog({super.key, this.userModel, required this.onClickAccept});

  final UserModel? userModel;
  final VoidCallback onClickAccept;

  @override
  Widget build(BuildContext context) {
    debugPrint('userName: ${userModel?.userName}');
    return CupertinoAlertDialog(
      title: TextView(
        text: 'Siz rostdan ham tizimdan chiqib ketmoqchimisiz?',
        textColor: Theme.of(context).colorScheme.onBackground,
      ),
      content: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: CachedImageView(
                imageUrl: userModel?.profileImg ?? ImageConstants.userImageUrl,
                width: 50,
                height: 50,
                borderRadius: 100,
              ),
            ),
            const SizedBox(height: 10),
            TextView(
              text: 'id: ${userModel?.id ?? 'null bolishi mumkin emas'}',
              textColor: Theme.of(context).colorScheme.onBackground,
              textSize: 14.textSize(context),
              maxLines: 1,
              textOverflow: TextOverflow.ellipsis,
            ),
            TextView(
              text: 'email: ${userModel?.email ?? 'null bolishi mumkin emas'}',
              textColor: Theme.of(context).colorScheme.onBackground,
              textSize: 14.textSize(context),
              maxLines: 1,
              textOverflow: TextOverflow.ellipsis,
            ),
            TextView(
              text:
                  'name: ${(userModel!.userName!.isNotEmpty) ? userModel?.userName : 'Mavjud emas(('}',
              textColor: Theme.of(context).colorScheme.onBackground,
              textSize: 14.textSize(context),
              maxLines: 1,
              textOverflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
      actions: <Widget>[
        CupertinoDialogAction(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: TextView(
            text: 'Cancel',
            textColor: Theme.of(context).colorScheme.onBackground,
          ),
        ),
        CupertinoDialogAction(
          onPressed: onClickAccept,
          child: TextView(
            text: 'Ha albatta',
            textColor: Theme.of(context).colorScheme.error,
          ),
        ),
      ],
    );
  }
}
