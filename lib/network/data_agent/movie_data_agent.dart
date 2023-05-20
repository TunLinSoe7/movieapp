
import 'package:movie_app/data/vos/actor_vo/result_vo/actor_result_vo.dart';
import 'package:movie_app/data/vos/genres_vo/genres_vo.dart';
import 'package:movie_app/data/vos/productionCompanies_vo/production_companies_vo.dart';
import 'package:movie_app/network/response/actor_detail_response/actor_detail_response.dart';

import '../../data/vos/movie_vo/result_vo.dart';
import '../response/moviedetails_response/movie_details_response.dart';

abstract class MovieDataAgent{

  Future<List<GenresVO>?> getGenresList();

  Future<List<MovieVO>?> getMoviesList();
  Future<List<MovieVO>?> getTopRatedMoviesList();
  Future<List<MovieVO>?> getPopularMoviesList();
  Future<List<ActorResultsVO>?> getActorList();
  Future<ActorDetailResponse?> getActorDetailList(int movieID);
  Future<MovieDetailsResponse?> getMovieDetails(int movieID);
  Future<List<ProductionCompaniesVO>?> getCompanyDetails(int movieID);
}
