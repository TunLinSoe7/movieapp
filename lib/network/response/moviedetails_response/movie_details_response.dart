import 'package:json_annotation/json_annotation.dart';

import '../../../data/vos/genres_vo/genres_vo.dart';
import '../../../data/vos/productionCompanies_vo/production_companies_vo.dart';
import '../../../data/vos/productionCountries_vo/production_countries_vo.dart';
import '../../../data/vos/spokenlanguages_vo/spoken_language_vo.dart';

part 'movie_details_response.g.dart';

@JsonSerializable()
class MovieDetailsResponse {
  @JsonKey(name: 'adult')
  bool? adult;

  @JsonKey(name: 'backdrop_path')
  String? backdropPath;

  @JsonKey(name: 'budget')
  int? budget;

  @JsonKey(name: 'genres')
  List<GenresVO>? genres;

  @JsonKey(name: 'homepage')
  String? homepage;

  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'imdb_id')
  String? imdbId;

  @JsonKey(name: 'original_language')
  String? originalLanguage;

  @JsonKey(name: 'original_title')
  String? originalTitle;

  @JsonKey(name: 'overview')
  String? overview;

  @JsonKey(name: 'popularity')
  double? popularity;

  @JsonKey(name: 'poster_path')
  String? posterPath;

  @JsonKey(name: 'production_companies')
  List<ProductionCompaniesVO>? productionCompanies;

  @JsonKey(name: 'production_countries')
  List<ProductionCountriesVO>? productionCountries;

  @JsonKey(name: 'release_date')
  String? releaseDate;

  @JsonKey(name: 'revenue')
  int? revenue;

  @JsonKey(name: 'runtime')
  int? runtime;

  @JsonKey(name: 'spoken_languages')
  List<SpokenLanguagesVO>? spokenLanguages;

  @JsonKey(name: 'status')
  String? status;

  @JsonKey(name: 'tagline')
  String? tagline;

  @JsonKey(name: 'title')
  String? title;

  @JsonKey(name: 'video')
  bool? video;

  @JsonKey(name: 'vote_average')
  double? voteAverage;

  @JsonKey(name: 'vote_count')
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
