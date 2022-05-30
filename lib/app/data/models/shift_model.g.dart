// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shift_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ShiftModelAdapter extends TypeAdapter<ShiftModel> {
  @override
  final int typeId = 4;

  @override
  ShiftModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ShiftModel(
      id: fields[0] as String?,
      name: fields[1] as String?,
      timeStart: fields[2] as String?,
      timeEnd: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ShiftModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.timeStart)
      ..writeByte(3)
      ..write(obj.timeEnd);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ShiftModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
