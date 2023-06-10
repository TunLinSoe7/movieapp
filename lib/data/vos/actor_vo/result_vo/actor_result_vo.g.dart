// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'actor_result_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ActorResultsVOAdapter extends TypeAdapter<ActorResultsVO> {
  @override
  final int typeId = 7;

  @override
  ActorResultsVO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ActorResultsVO(
      adult: fields[0] as bool?,
      gender: fields[1] as int?,
      id: fields[2] as int?,
      knownFor: (fields[3] as List?)?.cast<KnownFor>(),
      knownForDepartment: fields[4] as String?,
      name: fields[5] as String?,
      popularity: fields[6] as double?,
      profilePath: fields[7] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ActorResultsVO obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.adult)
      ..writeByte(1)
      ..write(obj.gender)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.knownFor)
      ..writeByte(4)
      ..write(obj.knownForDepartment)
      ..writeByte(5)
      ..write(obj.name)
      ..writeByte(6)
      ..write(obj.popularity)
      ..writeByte(7)
      ..write(obj.profilePath);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ActorResultsVOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActorResultsVO _$ActorResultsVOFromJson(Map<String, dynamic> json) =>
    ActorResultsVO(
      adult: json['adult'] as bool?,
      gender: json['gender'] as int?,
      id: json['id'] as int?,
      knownFor: (json['known_for'] as List<dynamic>?)
          ?.map((e) => KnownFor.fromJson(e as Map<String, dynamic>))
          .toList(),
      knownForDepartment: json['known_for_department'] as String?,
      name: json['name'] as String?,
      popularity: (json['popularity'] as num?)?.toDouble(),
      profilePath: json['profile_path'] as String?,
    );

Map<String, dynamic> _$ActorResultsVOToJson(ActorResultsVO instance) =>
    <String, dynamic>{
      'adult': instance.adult,
      'gender': instance.gender,
      'id': instance.id,
      'known_for': instance.knownFor,
      'known_for_department': instance.knownForDepartment,
      'name': instance.name,
      'popularity': instance.popularity,
      'profile_path': instance.profilePath,
    };
