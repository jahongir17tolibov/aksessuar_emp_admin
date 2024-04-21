import 'package:aksessuar_emp_admin/feature/home/data/remote/dto/users_order_dto.dart';
import 'package:aksessuar_emp_admin/feature/home/domain/model/users_order_model.dart';

extension UsersOrderDtoMapper on UsersOrderDto {
  UsersOrderModel toUsersOrderModel() => UsersOrderModel(
        number: number,
        userUid: userUid,
        ordersThisMonth: ordersThisMonth,
        amount: amount?.toDouble() ?? 0.0,
      );
}

extension UsersOrderModelMapper on UsersOrderModel {
  UsersOrderDto toUsersDtoModel() => UsersOrderDto(
        number: number,
        userUid: userUid,
        ordersThisMonth: ordersThisMonth,
        amount: amount,
      );
}
