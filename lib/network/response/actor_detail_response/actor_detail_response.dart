import 'package:json_annotation/json_annotation.dart';
part 'actor_detail_response.g.dart';
@JsonSerializable()
class ActorDetailResponse {
  @JsonKey(name: 'adult')
  bool? adult;
  @JsonKey(name: 'also_known_as')
  List<String>? alsoKnownAs;
  @JsonKey(name: 'biography')
  String? biography;
  @JsonKey(name: 'birthday')
  String? birthday;
  @JsonKey(name: 'deathday')
  String? deathDay;
  @JsonKey(name: 'gender')
  dynamic gender;
  @JsonKey(name: 'homepage')
  String? homepage;
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'imdb_id')
  String? imdbId;
  @JsonKey(name: 'known_for_department')
  String? knownForDepartment;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'place_of_birth')
  String? placeOfBirth;
  @JsonKey(name: 'popularity')
  double? popularity;
  @JsonKey(name: 'profile_path')
  String? profilePath;

ActorDetailResponse(
      {this.adult,
        this.alsoKnownAs,
        this.biography,
        this.birthday,
        this.deathDay,
        this.gender,
        this.homepage,
        this.id,
        this.imdbId,
        this.knownForDepartment,
        this.name,
        this.placeOfBirth,
        this.popularity,
        this.profilePath});

  factory ActorDetailResponse.fromJson(Map<String, dynamic> json) => _$ActorDetailResponseFromJson(json);
}