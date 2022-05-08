// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kehadiran_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class KehadiranAdapter extends TypeAdapter<Kehadiran> {
  @override
  final int typeId = 1;

  @override
  Kehadiran read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Kehadiran(
      userId: fields[0] as String?,
      waktuKehadiran: fields[1] as String?,
      statusKehadiran: fields[2] as StatusKehadiran?,
      shift: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Kehadiran obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.userId)
      ..writeByte(1)
      ..write(obj.waktuKehadiran)
      ..writeByte(2)
      ..write(obj.statusKehadiran)
      ..writeByte(3)
      ..write(obj.shift);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is KehadiranAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
