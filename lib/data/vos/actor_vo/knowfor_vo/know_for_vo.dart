import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../constant/hive_constant.dart';
part 'know_for_vo.g.dart';
@JsonSerializable()
@HiveType(typeId: kKnowForTypeID)
class KnownFor {
  @JsonKey(name: 'adult')
  @HiveField(0)
  bool? adult;
  @JsonKey(name: 'backdrop_path')
  @HiveField(1)
  String? backdropPath;
  @JsonKey(name: 'genre_ids')
  @HiveField(2)
  List<int>? genreIds;
  @JsonKey(name: 'id')
  @HiveField(3)
  int? id;
  @JsonKey(name: 'media_type')
  @HiveField(4)
  String? mediaType;
  @JsonKey(name: 'original_language')
  @HiveField(5)
  String? originalLanguage;
  @JsonKey(name: 'original_title')
  @HiveField(6)
  String? originalTitle;
  @JsonKey(name: 'overview')
  @HiveField(7)
  String? overview;
  @JsonKey(name: 'poster_path')
  @HiveField(8)
  String? posterPath;
  @JsonKey(name: 'release_date')
  @HiveField(9)
  String? releaseDate;
  @JsonKey(name: 'title')
  @HiveField(10)
  String? title;
  @JsonKey(name: 'video')
  @HiveField(11)
  bool? video;
  @JsonKey(name: 'vote_average')
  @HiveField(12)
  double? voteAverage;
  @JsonKey(name: 'vote_count')
  @HiveField(13)
  int? voteCount;

  KnownFor({this.adult,
    this.backdropPath,
    this.genreIds,
    this.id,
    this.mediaType,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
  });

  factory KnownFor.fromJson(Map<String, dynamic> json) =>_$KnownForFromJson(json);
}