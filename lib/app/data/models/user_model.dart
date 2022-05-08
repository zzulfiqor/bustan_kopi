import 'package:hive_flutter/hive_flutter.dart';

part 'user_model.g.dart';

@HiveType(typeId: 3)
class UserModel {
  @HiveField(0)
  String? id;

  @HiveField(1)
  String? name;

  @HiveField(2)
  String? email;

  @HiveField(3)
  String? password;

  @HiveField(4)
  String? role;

  @HiveField(5)
  String? token;

  @HiveField(6)
  String? createdAt;

  @HiveField(7)
  String? updatedAt;

  @HiveField(8)
  String? address;

  @HiveField(9)
  String? phone;

  @HiveField(10)
  String? photoPath;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.password,
    this.role,
    this.token,
    this.createdAt,
    this.updatedAt,
    this.address,
    this.phone,
    this.photoPath,
  });
}
