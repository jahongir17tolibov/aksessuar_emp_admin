import 'package:aksessuar_emp_admin/utils/constants.dart';
import 'package:hive/hive.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class HiveDatabase {
  static Future<void> initHiveFlutter() async {
    Hive.init(await _getAppDatabasePath());
    await Hive.openBox(HiveConstants.userStorageBox);
  }

  static Future<BoxCollection> initHiveDatabase() async {
    const boxes = {
      HiveConstants.cachedAdminDataBox,
    };
    return await BoxCollection.open(
      HiveConstants.databaseName,
      boxes,
      path: await _getAppDatabasePath(),
    );
  }

  static Future<String> _getAppDatabasePath() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    return join(documentsDirectory.path, HiveConstants.databaseName);
  }
}
