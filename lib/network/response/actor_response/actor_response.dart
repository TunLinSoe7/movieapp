import '../../../data/vos/actor_vo/result_vo/actor_result_vo.dart';
import 'package:json_annotation/json_annotation.dart';
part 'actor_response.g.dart';
@JsonSerializable()
class ActorResponse {
  @JsonKey(name: 'page')
  int? page;
  @JsonKey(name: 'results')
  List<ActorResultsVO>? results;
  @JsonKey(name: 'total_pages')
  int? totalPages;
  @JsonKey(name: 'total_results')
  int? totalResults;

  ActorResponse({this.page, this.results, this.totalPages, this.totalResults});

  factory ActorResponse.fromJson(Map<String, dynamic> json) =>_$ActorResponseFromJson(json);
}