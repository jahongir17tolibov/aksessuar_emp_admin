import '../dto/admin_dto.dart';

abstract interface class AuthRemoteDataSource {
  Future<AdminDto?> getAdminAuthData();
}
