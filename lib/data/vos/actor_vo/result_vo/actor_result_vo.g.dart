// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'actor_result_vo.dart';

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
