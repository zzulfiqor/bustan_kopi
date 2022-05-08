import 'package:hive_flutter/hive_flutter.dart';

part 'status_kehadiran_enum.g.dart';

@HiveType(typeId: 2)
enum StatusKehadiran {
  @HiveField(0)
  Hadir,

  @HiveField(1)
  TidakHadir,
}