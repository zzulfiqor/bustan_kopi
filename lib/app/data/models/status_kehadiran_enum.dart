import 'package:hive_flutter/hive_flutter.dart';

part 'status_kehadiran_enum.g.dart';

@HiveType(typeId: 2)
enum StatusKehadiran {
  @HiveField(0)
  Hadir,

  @HiveField(1)
  TidakHadir,

  @HiveField(2)
  Terlambat,

  @HiveField(3)
  Ijin,

  @HiveField(4)
  Sakit,

  @HiveField(5)
  TerlaluPagi,

}