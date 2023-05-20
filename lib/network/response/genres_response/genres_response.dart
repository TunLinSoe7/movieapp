import 'package:json_annotation/json_annotation.dart';
import '../../../data/vos/genres_vo/genres_vo.dart';
part 'genres_response.g.dart';
@JsonSerializable()
class GenresResponse{
  @JsonKey(name:'genres')
  List<GenresVO>? genres;
  GenresResponse(this.genres);
  factory GenresResponse.fromJson(Map<String,dynamic> json)=>
      _$GenresResponseFromJson(json);
}