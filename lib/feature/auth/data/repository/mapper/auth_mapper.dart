import 'package:aksessuar_emp_admin/feature/auth/data/remote/dto/user_dto.dart';
import 'package:aksessuar_emp_admin/feature/auth/domain/model/user_model.dart';

// extension AdminDtoMapper on User {
//   AdminEntity toAdminEntity() => AdminEntity(
//         id: id,
//         login: email,
//         password: userName,
//         registeredTime: profileImg.toString(),
//       );
// }

extension UserDtoMapper on UserDto {
  UserModel toUserModel() => UserModel(
        id: userUId,
        email: email,
        userName: userName,
        profileImg: userProfileUrl,
      );
}
