import 'package:hive_flutter/adapters.dart';
part 'shift_model.g.dart';

@HiveType(typeId: 4)
class ShiftModel {

  @HiveField(0)
  String? id;

  @HiveField(1)
  String? name;

  @HiveField(2)
  String? timeStart;
  
  @HiveField(3)
  String? timeEnd;

  ShiftModel({
    this.id,
    this.name,
    this.timeStart,
    this.timeEnd,
  });
}
