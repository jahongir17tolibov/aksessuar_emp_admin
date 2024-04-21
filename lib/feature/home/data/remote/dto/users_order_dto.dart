import 'package:equatable/equatable.dart';

class UsersOrderDto extends Equatable {
  const UsersOrderDto({
    this.number,
    this.userUid,
    this.ordersThisMonth,
    this.amount,
  });

  final int? number;
  final String? userUid;
  final int? ordersThisMonth;
  final num? amount;

  Map<String, dynamic> toMap() => <String, dynamic>{
        'number': number,
        'user_uid': userUid ?? '',
        'orders_this_month': ordersThisMonth,
        'amount': amount,
      };

  factory UsersOrderDto.fromMap(Map<String, dynamic> json) => UsersOrderDto(
        number: json['number'],
        userUid: json['user_uid'],
        ordersThisMonth: json['orders_this_month'],
        amount: json['amount'],
      );

  @override
  List<Object?> get props => [number, userUid, ordersThisMonth, amount];
}
