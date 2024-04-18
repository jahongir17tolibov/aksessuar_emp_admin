import 'package:aksessuar_emp_admin/feature/auth/data/local/entity/admin_entity.dart';
import 'package:aksessuar_emp_admin/feature/auth/data/remote/dto/admin_dto.dart';
import 'package:aksessuar_emp_admin/feature/auth/domain/model/admin_model.dart';

extension AdminDtoMapper on AdminDto {
  AdminEntity toAdminEntity() => AdminEntity(
        id: id,
        login: login,
        password: password,
        registeredTime: registeredTime.toString(),
      );
}

extension AdminEntityMapper on AdminEntity {
  AdminModel toAdminModel() => AdminModel(
        id: id,
        login: login,
        password: password,
        registeredTime: registeredTime,
      );
}
