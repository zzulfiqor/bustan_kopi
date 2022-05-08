// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'status_kehadiran_enum.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StatusKehadiranAdapter extends TypeAdapter<StatusKehadiran> {
  @override
  final int typeId = 2;

  @override
  StatusKehadiran read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return StatusKehadiran.Hadir;
      case 1:
        return StatusKehadiran.TidakHadir;
      default:
        return StatusKehadiran.Hadir;
    }
  }

  @override
  void write(BinaryWriter writer, StatusKehadiran obj) {
    switch (obj) {
      case StatusKehadiran.Hadir:
        writer.writeByte(0);
        break;
      case StatusKehadiran.TidakHadir:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StatusKehadiranAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
