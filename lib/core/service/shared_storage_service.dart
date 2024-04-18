import 'package:hive/hive.dart';

class HiveSharedStorageService {
  Box _getBox(String name) => Hive.box(name);

  void saveBool({required String boxName, required String key, required bool value}) {
    _getBox(boxName).put(key, value);
  }

  bool getBool({required String boxName, required String key, required bool value}) {
    final bool? value = _getBox(boxName).get(key);
    return value ?? false;
  }

  void deleteBool({required String boxName, required String key}) {
    _getBox(boxName).delete(key);
  }

  void saveString({required String boxName, required String key, required String value}) {
    _getBox(boxName).put(key, value);
  }

  String getString({required String boxName, required String key}) {
    final String? value = _getBox(boxName).get(key);
    return value ?? '';
  }

  void deleteString({required String boxName, required String key}) {
    _getBox(boxName).delete(key);
  }

  void saveInt({required String boxName, required String key, required int value}) {
    _getBox(boxName).put(key, value);
  }

  int getInt({required String boxName, required String key}) {
    final int? value = _getBox(boxName).get(key);
    return value ?? -1;
  }

  void deleteInt({required String boxName, required String key}) {
    _getBox(boxName).delete(key);
  }
}
