import 'package:bustan_kopi/app/data/models/shift_model.dart';
import 'package:bustan_kopi/app/data/models/status_kehadiran_enum.dart';
import 'package:hive_flutter/adapters.dart';

part 'kehadiran_model.g.dart';

@HiveType(typeId: 1)
class Kehadiran {
  @HiveField(0)
  String? userId;

  @HiveField(1)
  String? waktuKehadiran;

  @HiveField(2)
  StatusKehadiran? statusKehadiran;

  @HiveField(3)
  ShiftModel? shift;

  Kehadiran({
    this.userId,
    this.waktuKehadiran,
    this.statusKehadiran,
    this.shift,
  });
}

