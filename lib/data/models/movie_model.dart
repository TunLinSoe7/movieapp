import 'package:movie_app/data/vos/actor_vo/result_vo/actor_result_vo.dart';
import 'package:movie_app/data/vos/genres_vo/genres_vo.dart';
import 'package:movie_app/data/vos/productionCompanies_vo/production_companies_vo.dart';
import 'package:movie_app/network/response/moviedetails_response/movie_details_response.dart';

import '../../network/response/actor_detail_response/actor_detail_response.dart';
import '../vos/movie_vo/result_vo.dart';

abstract class MovieModel{
  Future<List<GenresVO>?> getGenresList();
  Stream<List<GenresVO>?> getGenresListFromDataBase();
  ///GetNowPlaying
  Future<List<MovieVO>?> getMoviesList();
  Stream<List<MovieVO>?> getMovieListFromDataBase();
  ///TopRatedMovies
  Future<List<MovieVO>?> getTopRatedMoviesList();
  Stream<List<MovieVO>?> getTopRatedMovieListFromDataBase();
  ///PopularMovies
  Future<List<MovieVO>?> getPopularMoviesList();
  Stream<List<MovieVO>?> getPopularMoviesListFromDataBase();
  ///Actor
  Future<List<ActorResultsVO>?> getActorList();
  Stream<List<ActorResultsVO>?> getActorListFromDataBase();
  Future<ActorDetailResponse?> getActorDetailList(int actorID);
  ///MovieDetail
  Future<MovieDetailsResponse?> getMovieDetails(int movieID);
  Stream<MovieDetailsResponse?> getMovieDetailListFromDataBase(int movieID);

  Future<List<ProductionCompaniesVO>?> getCompanyList(int movieID);
}