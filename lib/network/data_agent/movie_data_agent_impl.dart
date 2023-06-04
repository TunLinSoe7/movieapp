import 'package:dio/dio.dart';
import 'package:movie_app/constant/api_constant.dart';
import 'package:movie_app/data/vos/actor_vo/result_vo/actor_result_vo.dart';
import 'package:movie_app/data/vos/genres_vo/genres_vo.dart';
import 'package:movie_app/data/vos/movie_vo/result_vo.dart';
import 'package:movie_app/data/vos/productionCompanies_vo/production_companies_vo.dart';
import 'package:movie_app/network/api/movie_api.dart';
import 'package:movie_app/network/response/actor_detail_response/actor_detail_response.dart';
import 'package:movie_app/network/response/moviedetails_response/movie_details_response.dart';
import 'movie_data_agent.dart';


class MovieDataAgentImpl extends MovieDataAgent {
  late MovieApi _api;

  MovieDataAgentImpl._() {
    _api = MovieApi(Dio());
  }

  static final MovieDataAgentImpl _singleton = MovieDataAgentImpl._();

  factory MovieDataAgentImpl() => _singleton;

  @override
  Future<List<GenresVO>?> getGenresList() => _api
     .getGenresResponse(kApiKey)
      .asStream()
      .map((event) => event.genres)
      .first;

  @override
  Future<List<MovieVO>?> getMoviesList() {
    return _api
      .getNowPlayingMovieResponse(kApiKey)
      .asStream()
      .map((event) => event.results)
      .first;}
  @override
  Future<List<MovieVO>?> getTopRatedMoviesList() {
    return _api
      .getTopRatedResponse(kApiKey)
      .asStream()
      .map((event) => event.results)
      .first;}

  @override
  Future<List<MovieVO>?> getPopularMoviesList() => _api
      .getPopularMoviesResponse(kApiKey)
      .asStream()
      .map((event) => event.results)
      .first;

  @override
  Future<List<ActorResultsVO>?> getActorList() =>_api
      .getActorResponse(kApiKey)
      .asStream()
      .map((event) => event.results)
      .first;

  @override
  Future<ActorDetailResponse?> getActorDetailList(int movieID) =>_api
      .getActorDetailResponse(kApiKey, movieID);

  @override
  Future<MovieDetailsResponse?> getMovieDetails(int movieID) =>
      _api.getMovieDetailsResponse(kApiKey, movieID);

  @override
  Future<List<ProductionCompaniesVO>?> getCompanyDetails(int movieID)=>
      _api.getMovieDetailsResponse(kApiKey, movieID)
      .asStream()
      .map((event) => event.productionCompanies)
      .first;

}
