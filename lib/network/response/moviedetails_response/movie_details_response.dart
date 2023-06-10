import 'package:json_annotation/json_annotation.dart';
import 'package:movie_app/constant/hive_constant.dart';

import '../../../data/vos/genres_vo/genres_vo.dart';
import '../../../data/vos/productionCompanies_vo/production_companies_vo.dart';
import '../../../data/vos/productionCountries_vo/production_countries_vo.dart';
import '../../../data/vos/spokenlanguages_vo/spoken_language_vo.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'movie_details_response.g.dart';

@JsonSerializable()
@HiveType(typeId: kMovieDetailTypeID)
class MovieDetailsResponse {

  @JsonKey(name: 'adult')
  @HiveField(0)
  bool? adult;

  @JsonKey(name: 'backdrop_path')
  @HiveField(1)
  String? backdropPath;

  @JsonKey(name: 'budget')
  @HiveField(2)
  int? budget;

  @JsonKey(name: 'genres')
  @HiveField(3)
  List<GenresVO>? genres;

  @JsonKey(name: 'homepage')
  @HiveField(4)
  String? homepage;

  @JsonKey(name: 'id')
  @HiveField(5)
  int? id;

  @JsonKey(name: 'imdb_id')
  @HiveField(6)
  String? imdbId;

  @JsonKey(name: 'original_language')
  @HiveField(7)
  String? originalLanguage;

  @JsonKey(name: 'original_title')
  @HiveField(8)
  String? originalTitle;

  @JsonKey(name: 'overview')
  @HiveField(9)
  String? overview;

  @JsonKey(name: 'popularity')
  @HiveField(10)
  double? popularity;

  @JsonKey(name: 'poster_path')
  @HiveField(11)
  String? posterPath;

  @JsonKey(name: 'production_companies')
  @HiveField(12)
  List<ProductionCompaniesVO>? productionCompanies;

  @JsonKey(name: 'production_countries')
  @HiveField(13)
  List<ProductionCountriesVO>? productionCountries;

  @JsonKey(name: 'release_date')
  @HiveField(14)
  String? releaseDate;

  @JsonKey(name: 'revenue')
  @HiveField(15)
  int? revenue;

  @JsonKey(name: 'runtime')
  @HiveField(16)
  int? runtime;

  @JsonKey(name: 'spoken_languages')
  @HiveField(17)
  List<SpokenLanguagesVO>? spokenLanguages;

  @JsonKey(name: 'status')
  @HiveField(18)
  String? status;

  @JsonKey(name: 'tagline')
  @HiveField(19)
  String? tagline;

  @JsonKey(name: 'title')
  @HiveField(20)
  String? title;

  @JsonKey(name: 'video')
  @HiveField(21)
  bool? video;

  @JsonKey(name: 'vote_average')
  @HiveField(22)
  double? voteAverage;

  @JsonKey(name: 'vote_count')
  @HiveField(23)
  int? voteCount;

  MovieDetailsResponse(
      this.adult,
      this.backdropPath,
      this.budget,
      this.genres,
      this.homepage,
      this.id,
      this.imdbId,
      this.originalLanguage,
      this.originalTitle,
      this.overview,
      this.popularity,
      this.posterPath,
      this.productionCompanies,
      this.productionCountries,
      this.releaseDate,
      this.revenue,
      this.runtime,
      this.spokenLanguages,
      this.status,
      this.tagline,
      this.title,
      this.video,
      this.voteAverage,
      this.voteCount);

  factory MovieDetailsResponse.fromJson(Map<String, dynamic> json) =>
      _$MovieDetailsResponseFromJson(json);
}
