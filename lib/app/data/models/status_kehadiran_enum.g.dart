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
      case 2:
        return StatusKehadiran.Terlambat;
      case 3:
        return StatusKehadiran.Ijin;
      case 4:
        return StatusKehadiran.Sakit;
      case 5:
        return StatusKehadiran.TerlaluPagi;
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
      case StatusKehadiran.Terlambat:
        writer.writeByte(2);
        break;
      case StatusKehadiran.Ijin:
        writer.writeByte(3);
        break;
      case StatusKehadiran.Sakit:
        writer.writeByte(4);
        break;
      case StatusKehadiran.TerlaluPagi:
        writer.writeByte(5);
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
