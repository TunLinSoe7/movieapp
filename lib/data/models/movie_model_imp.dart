
import 'package:movie_app/data/vos/genres_vo/genres_vo.dart';
import 'package:movie_app/data/vos/movie_vo/result_vo.dart';
import 'package:movie_app/data/vos/productionCompanies_vo/production_companies_vo.dart';
import 'package:movie_app/network/response/actor_detail_response/actor_detail_response.dart';
import 'package:movie_app/network/response/moviedetails_response/movie_details_response.dart';

import '../../network/data_agent/movie_data_agent.dart';
import '../../network/data_agent/movie_data_agent_impl.dart';
import '../vos/actor_vo/result_vo/actor_result_vo.dart';
import 'movie_model.dart';

class MovieModelImpl extends MovieModel {
  MovieModelImpl._();

  static final MovieModelImpl _singleton = MovieModelImpl._();

  factory MovieModelImpl() => _singleton;

  final MovieDataAgent _movieDataAgent = MovieDataAgentImpl();


  @override
  Future<List<GenresVO>?> getGenresList() => _movieDataAgent.getGenresList();

  @override
  Future<List<MovieVO>?> getMoviesList() => _movieDataAgent.getMoviesList();

  @override
  Future<List<MovieVO>?> getTopRatedMoviesList() =>
      _movieDataAgent.getTopRatedMoviesList();

  @override
  Future<List<MovieVO>?> getPopularMoviesList() =>
      _movieDataAgent.getPopularMoviesList();

  @override
  Future<List<ActorResultsVO>?> getActorList() =>
      _movieDataAgent.getActorList();

  @override
  Future<ActorDetailResponse?> getActorDetailList(int movieID) =>
      _movieDataAgent.getActorDetailList(movieID).then((value) {
        final actorData = value;
        if (actorData?.deathDay == null || actorData?.deathDay == '') {
          actorData?.deathDay = '-';
        }
        return actorData;
      });

  @override
  Future<MovieDetailsResponse?> getMovieDetails(int movieID) =>
      _movieDataAgent.getMovieDetails(movieID);

  @override
  Future<List<ProductionCompaniesVO>?> getCompanyList(int movieID) =>
      _movieDataAgent.getCompanyDetails(movieID)
  .then((value) {
    final companyData =  value;
    companyData?.toList().map((e) {
      final data = e;
      data == null || data==""?data.logoPath == "https://image.tmdb.org/t/p/w500/2RYvU63aWqdRvzvGhAZlGpbIOqA.jpg": data.logoPath;
    });
return companyData;
  }
  );
}