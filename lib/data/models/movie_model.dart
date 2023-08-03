import 'package:movie_app/data/vos/actor_vo/result_vo/actor_result_vo.dart';
import 'package:movie_app/data/vos/credit_vo/cast_vo.dart';
import 'package:movie_app/data/vos/credit_vo/crew_hive_vo.dart';
import 'package:movie_app/data/vos/genres_vo/genres_vo.dart';
import 'package:movie_app/data/vos/movie_vo/movie_hive_vo.dart';
import 'package:movie_app/data/vos/productionCompanies_vo/production_companies_vo.dart';
import 'package:movie_app/network/response/moviedetails_response/movie_details_response.dart';

import '../../network/response/actor_detail_response/actor_detail_response.dart';
import '../vos/credit_vo/cast_hive_vo.dart';
import '../vos/credit_vo/crew_vo.dart';
import '../vos/movie_vo/result_vo.dart';

abstract class MovieModel{
  ///Genres
  Future<List<GenresVO>?> getGenresList();
  Stream<List<GenresVO>?> getGenresListFromDataBase();
  ///TopRatedMovies
  Future<List<MovieVO>?> getTopRatedMoviesList(int page);
  Stream<List<MovieVO>?> getTopRatedMovieListFromDataBase(int page);
  ///PopularMovies
  Future<List<MovieVO>?> getPopularMoviesList(int page);
  Stream<List<MovieVO>?> getPopularMoviesListFromDataBase(int page);
  ///Actor
  Future<List<ActorResultsVO>?> getActorList();
  Stream<List<ActorResultsVO>?> getActorListFromDataBase();

  ///MovieDetail
  Future<MovieDetailsResponse?> getMovieDetails(int movieID);
  Stream<MovieDetailsResponse?> getMovieDetailListFromDataBase(int movieID);
///Similar Movies
  Future<List<MovieVO>?> getSimilarMoviesList(int movieID);
  Stream<MovieHiveVO?> getSimilarMovieListFromDataBase(int movieID);
  ///Cast
  Future<List<CastVO>?> getCastList(int castID);
  Stream<CastHiveVO?> getCastListFromDataBase(int castID);
  ///Crew
  Future<List<CrewVO>?> getCrewList(int crewID);
  Stream<CrewHiveVO?> getCrewListFromDataBase(int crewID);
  ///Search
  Future<List<MovieVO>?> getSearchMoviesList(String query);
  ///MovieByGenre
  Future<List<MovieVO>?> getMovieByGenreIDList(int genreID);
  Stream<List<MovieVO>?> getMovieByGenreIDFromDataBase(int genreID);
  ///Actor detail
  Future<ActorDetailResponse?> getActorDetailResponse(int actorID);
  Stream<ActorDetailResponse?> getActorDetailFromDataBase(int actorID);

}