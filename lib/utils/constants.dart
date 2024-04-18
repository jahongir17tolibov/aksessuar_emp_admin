import 'package:cloud_firestore/cloud_firestore.dart';

class AppConstants {}

class HiveConstants {
  static const String databaseName = 'akksessuar_admin_app.db';
  static const String cachedAdminDataBox = 'cached_admin_box';
  static const String encryptionKey = 'aksessuar_encryption_key';
}

class FireStoreConstants {
  static const String adminAuthCollection = 'admin_auth';
  static const String categoriesCollection = 'categories';
  static const String employeesCollection = 'employees';
  static const String productsCollection = 'products';
  static const GetOptions fireStoreGetOptions = GetOptions(source: Source.server);
}

class ImageConstants {
  static const String adminDefaultImg = 'assets/image/admin_default_img.png';
}
