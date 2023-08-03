// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_hive_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MovieHiveVOAdapter extends TypeAdapter<MovieHiveVO> {
  @override
  final int typeId = 13;

  @override
  MovieHiveVO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MovieHiveVO(
      resultVO: (fields[0] as List?)?.cast<MovieVO>(),
    );
  }

  @override
  void write(BinaryWriter writer, MovieHiveVO obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.resultVO);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MovieHiveVOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
