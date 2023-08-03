// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cast_hive_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CastHiveVOAdapter extends TypeAdapter<CastHiveVO> {
  @override
  final int typeId = 11;

  @override
  CastHiveVO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CastHiveVO(
      (fields[0] as List).cast<CastVO>(),
    );
  }

  @override
  void write(BinaryWriter writer, CastHiveVO obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.hiveCast);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CastHiveVOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
