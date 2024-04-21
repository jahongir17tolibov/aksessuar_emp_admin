import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
class UsersOrderModel extends Equatable {
  const UsersOrderModel({
    this.number,
    this.userUid,
    this.ordersThisMonth,
    this.amount,
  });

  final int? number;
  final String? userUid;
  final int? ordersThisMonth;
  final double? amount;

  @override
  List<Object?> get props => [number, userUid, ordersThisMonth, amount];
}
