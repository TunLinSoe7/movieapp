
import 'package:movie_app/data/vos/actor_vo/result_vo/actor_result_vo.dart';
import 'package:movie_app/data/vos/credit_vo/cast_vo.dart';
import 'package:movie_app/data/vos/credit_vo/crew_vo.dart';
import 'package:movie_app/data/vos/genres_vo/genres_vo.dart';
import 'package:movie_app/data/vos/productionCompanies_vo/production_companies_vo.dart';
import 'package:movie_app/network/response/actor_detail_response/actor_detail_response.dart';
import '../../data/vos/movie_vo/result_vo.dart';
import '../response/moviedetails_response/movie_details_response.dart';
abstract class MovieDataAgent{
  Future<List<GenresVO>?> getGenresList();
  Future<List<MovieVO>?> getTopRatedMoviesList(int page);
  Future<List<MovieVO>?> getPopularMoviesList(int page);
  Future<List<ActorResultsVO>?> getActorList();
  Future<ActorDetailResponse?> getActorDetailList(int movieID);
  Future<MovieDetailsResponse?> getMovieDetails(int movieID);
  Future<List<ProductionCompaniesVO>?> getCompanyDetails(int movieID);
  Future<List<MovieVO>?> getSimilarMovieList(int movieID);
  Future<List<CastVO>?> getCastList(int movieID);
  Future<List<CrewVO>?> getCrewList(int movieID);
  Future<List<MovieVO>?> getSearchMoviesList();
  Future<List<MovieVO>?> getMoviesByGenreIDList(int genreID);
}
