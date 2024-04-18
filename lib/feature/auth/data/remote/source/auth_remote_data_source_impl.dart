import 'package:aksessuar_emp_admin/feature/auth/data/remote/source/auth_remote_data_source.dart';
import 'package:aksessuar_emp_admin/feature/auth/data/remote/dto/admin_dto.dart';
import 'package:aksessuar_emp_admin/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl({required FirebaseFirestore fireStore}) : _fireStore = fireStore;

  final FirebaseFirestore _fireStore;

  @override
  Future<AdminDto?> getAdminAuthData() async {
    try {
      final adminsData = await _fireStore
          .collection(FireStoreConstants.adminAuthCollection)
          .get(FireStoreConstants.fireStoreGetOptions);
      print('resgister time${AdminDto.fromJson(adminsData.docs.single.data()).registeredTime}');
      return AdminDto.fromJson(adminsData.docs.single.data());
    } on FirebaseException catch (e) {
      throw Exception(e);
    }
  }
}
