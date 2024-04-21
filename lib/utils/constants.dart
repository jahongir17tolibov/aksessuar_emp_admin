import 'package:cloud_firestore/cloud_firestore.dart';

class AppConstants {}

class HiveConstants {
  static const String databaseName = 'akksessuar_admin_app.db';
  static const String cachedAdminDataBox = 'cached_admin_box';
  static const String userStorageBox = 'user_storage_box';
  static const String userUIdKey = 'user_uid_key';
  static const String ordersLastItemNumberKey = 'orders_last_item_number_key';
}

class FirebaseConstants {
  static const String adminAuthCollection = 'admin_auth';
  static const String categoriesCollection = 'categories';
  static const String employeesCollection = 'employees';
  static const String productsCollection = 'products';
  static const String testDataCollection = 'orders_test';
  static const GetOptions fireStoreGetOptions = GetOptions(source: Source.server);
}

class ImageConstants {
  static const String adminDefaultImg = 'assets/image/admin_default_img.png';
  static const String googleLogoImg = 'assets/image/google_logo.webp';
  static const String userImageUrl =
      "https://uxwing.com/wp-content/themes/uxwing/download/peoples-avatars/default-profile-picture-grey-male-icon.png";
}
