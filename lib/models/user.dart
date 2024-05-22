import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 1)
class DataModel {

  DataModel({required this.username, required this.password});

  @HiveField(0)
  String username;

  @HiveField(1)
  String password;

  @override
  String toString() {
    return 'DataModel{username: $username, password: $password}';
  }
}