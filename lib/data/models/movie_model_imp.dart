import 'package:movie_app/data/vos/genres_vo/genres_vo.dart';
import 'package:movie_app/data/vos/movie_vo/result_vo.dart';
import 'package:movie_app/data/vos/productionCompanies_vo/production_companies_vo.dart';
import 'package:movie_app/network/response/actor_detail_response/actor_detail_response.dart';
import 'package:movie_app/network/response/moviedetails_response/movie_details_response.dart';
import 'package:movie_app/persistent/daos/actor_dao/actor_dao.dart';
import 'package:movie_app/persistent/daos/actor_dao/actor_dao_impl.dart';
import 'package:movie_app/persistent/daos/movie_dao/movie_dao.dart';
import 'package:movie_app/persistent/daos/movie_dao/movie_dao_impl.dart';
import 'package:movie_app/persistent/daos/movie_detail_dao/movie_detail_dao.dart';
import 'package:movie_app/persistent/daos/movie_detail_dao/movie_detail_dao_impl.dart';
import 'package:stream_transform/stream_transform.dart';

import '../../network/data_agent/movie_data_agent.dart';
import '../../network/data_agent/movie_data_agent_impl.dart';
import '../../persistent/daos/genres_dao/genres_dao.dart';
import '../../persistent/daos/genres_dao/genres_dao_impl.dart';
import '../vos/actor_vo/result_vo/actor_result_vo.dart';
import 'movie_model.dart';

class MovieModelImpl extends MovieModel {
  MovieModelImpl._();

  static final MovieModelImpl _singleton = MovieModelImpl._();

  factory MovieModelImpl() => _singleton;

  final MovieDataAgent _movieDataAgent = MovieDataAgentImpl();
  final MovieDAO _movieDAO = MovieDAOImpl();
  final GenresDAO _genresDAO = GenresDAOImpl();
  final ActorDAO _actorDAO = ActorDAOImpl();
  final MovieDetailResponseDAO _movieDetailResponseDAO = MovieDetailDAOImpl();

  ///Genres
  @override
  Future<List<GenresVO>?> getGenresList() =>
      _movieDataAgent.getGenresList().then((value) {
        if (value != null) {
          _genresDAO.save(value);
        }
        return value;
      });

  @override
  Stream<List<GenresVO>?> getGenresListFromDataBase() => _genresDAO
      .watchBox()
      .startWith(_genresDAO.getGenresListFromDataBaseStream())
      .map((event) => _genresDAO.getGenresListFromDataBase());

  @override
  Future<List<MovieVO>?> getMoviesList() =>
      _movieDataAgent.getMoviesList().then((value) {
        if (value != null) {
          var temp = value;
          temp = temp.map((e) {
            e.isGetNowPlaying = true;
            return e;
          }).toList();
          _movieDAO.save(value);
        }
      });

  @override
  Future<List<MovieVO>?> getTopRatedMoviesList() =>
      _movieDataAgent.getTopRatedMoviesList().then((value) {
        if (value != null) {
          var temp = value;
          temp = temp.map((e) {
            e.isTopRated = true;
            return e;
          }).toList();
          _movieDAO.save(value);
        }
      });

  ///Popular Movies
  @override
  Future<List<MovieVO>?> getPopularMoviesList() =>
      _movieDataAgent.getPopularMoviesList().then((value) {
        if (value != null) {
          var temp = value;
          temp = temp.map((e) {
            e.isPopularMovies = true;
            return e;
          }).toList();
          _movieDAO.save(value);
        }
      });

  @override
  Stream<List<MovieVO>?> getPopularMoviesListFromDataBase() => _movieDAO
      .watchMovieBox()
      .startWith(_movieDAO.getPopularMoviesListFromDataBaseStream())
      .map((event) => _movieDAO.getPopularMoviesListFromDataBase());

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
  Future<List<ProductionCompaniesVO>?> getCompanyList(int movieID) =>
      _movieDataAgent.getCompanyDetails(movieID).then((value) {
        final companyData = value;
        companyData?.toList().map((e) {
          final data = e;
          data == null || data == ""
              ? data.logoPath ==
                  "https://image.tmdb.org/t/p/w500/2RYvU63aWqdRvzvGhAZlGpbIOqA.jpg"
              : data.logoPath;
        });
        return companyData;
      });

  @override
  Stream<List<MovieVO>?> getMovieListFromDataBase() => _movieDAO
      .watchMovieBox()
      .startWith(_movieDAO.getNowPlayingListFromDataBaseStream())
      .map((event) => _movieDAO.getNowPlayingListFromDataBase());

  @override
  Stream<List<MovieVO>?> getTopRatedMovieListFromDataBase() => _movieDAO
      .watchMovieBox()
      .startWith(_movieDAO.getTopRatedFromDataBaseStream())
      .map((event) => _movieDAO.getTopRatedListFromDataBase());

  ///MovieDetail
  @override
  Future<MovieDetailsResponse?> getMovieDetails(int movieID) =>
      _movieDataAgent.getMovieDetails(movieID).then((value) {
        if (value != null) {
          _movieDetailResponseDAO.save(value);
        }
        return value;
      });

  @override
  Stream<MovieDetailsResponse?> getMovieDetailListFromDataBase(int movieID) =>
      _movieDetailResponseDAO
          .watchBox()
          .startWith(_movieDetailResponseDAO
              .getMovieDetailResponseFromDataBaseStream(movieID))
          .map((event) =>
              _movieDetailResponseDAO.getMovieDetailResponseFromDataBase(movieID));
///Actor
  @override
  Future<List<ActorResultsVO>?> getActorList() =>
      _movieDataAgent.getActorList().then((value) {
        if (value != null) {
          _actorDAO.save(value);
        }
        return value;
      });

  @override
  Stream<List<ActorResultsVO>?> getActorListFromDataBase() => _actorDAO
      .watchBox()
      .startWith(_actorDAO.getActorResultsVOFromDatabaseFromStream())
      .map((event) => _actorDAO.getActorResultsVOFromDatabase());
}
