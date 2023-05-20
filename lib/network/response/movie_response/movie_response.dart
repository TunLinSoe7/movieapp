import 'package:json_annotation/json_annotation.dart';

import '../../../data/vos/date_vo/date_vo.dart';
import '../../../data/vos/movie_vo/result_vo.dart';

part 'movie_response.g.dart';

@JsonSerializable()
class MovieResponse {
  @JsonKey(name: 'dates')
  DatesVO? dates;

  @JsonKey(name: 'page')
  int? page;

  @JsonKey(name: 'results')
  List<MovieVO>? results;

  @JsonKey(name: 'total_pages')
  int? totalPages;

  @JsonKey(name: 'total_results')
  int? totalResults;

  MovieResponse(
      {this.dates,
        this.page,
        this.results,
        this.totalPages,
        this.totalResults});

  factory MovieResponse.fromJson(Map<String, dynamic> json) =>
      _$MovieResponseFromJson(json);
}
