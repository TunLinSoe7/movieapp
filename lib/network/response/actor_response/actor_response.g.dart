// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'actor_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActorResponse _$ActorResponseFromJson(Map<String, dynamic> json) =>
    ActorResponse(
      page: json['page'] as int?,
      results: (json['results'] as List<dynamic>?)
          ?.map((e) => ActorResultsVO.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalPages: json['total_pages'] as int?,
      totalResults: json['total_results'] as int?,
    );

Map<String, dynamic> _$ActorResponseToJson(ActorResponse instance) =>
    <String, dynamic>{
      'page': instance.page,
      'results': instance.results,
      'total_pages': instance.totalPages,
      'total_results': instance.totalResults,
    };
