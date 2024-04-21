import 'package:aksessuar_emp_admin/feature/home/domain/model/users_order_model.dart';
import 'package:aksessuar_emp_admin/feature/home/presentation/widget/rich_text_for_item.dart';
import 'package:aksessuar_emp_admin/utils/designing_system/components/size_util.dart';
import 'package:aksessuar_emp_admin/utils/designing_system/components/text_view.dart';
import 'package:flutter/material.dart';

class UsersOrderListItem extends StatelessWidget {
  const UsersOrderListItem({super.key, required this.usersOrderModel, required this.onClickDeleteBtn});

  final UsersOrderModel usersOrderModel;
  final VoidCallback onClickDeleteBtn;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: ListTile(
        contentPadding: const EdgeInsets.all(8.0),
        tileColor: Theme.of(context).colorScheme.tertiaryContainer,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Theme.of(context).colorScheme.primary),
          borderRadius: BorderRadius.circular(6),
        ),
        leading: TextView(
          text: usersOrderModel.number!.toString(),
          textSize: 16.textSize(context),
          textColor: Theme.of(context).colorScheme.onTertiaryContainer,
          fontWeight: FontWeight.bold,
        ),
        title: TextView(
          text: usersOrderModel.userUid ?? ' ',
          textSize: 20.textSize(context),
          textColor: Theme.of(context).colorScheme.onTertiaryContainer,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            RichTextForItem(
              startText: 'orders this month',
              endText: usersOrderModel.ordersThisMonth?.toString() ?? ' ',
            ),
            RichTextForItem(
              startText: 'amount',
              endText: "${usersOrderModel.amount?.toString()}\$" ?? ' ',
            ),
          ],
        ),
        trailing: IconButton(
          onPressed: onClickDeleteBtn,
          icon: Icon(
            Icons.delete_outline,
            color: Theme.of(context).colorScheme.onTertiaryContainer,
          ),
        ),
      ),
    );
  }
}
