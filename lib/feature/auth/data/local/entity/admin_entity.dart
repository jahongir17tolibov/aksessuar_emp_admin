import 'package:hive/hive.dart';

part 'admin_entity.g.dart';

@HiveType(typeId: 0)
class AdminEntity extends HiveObject {
  AdminEntity({
    required this.id,
    required this.login,
    required this.password,
    required this.registeredTime,
  });

  @HiveField(0)
  final String id;

  @HiveField(1)
  final String login;

  @HiveField(2)
  final String password;

  @HiveField(3)
  final String registeredTime;
}
