import 'package:movie_app/data/vos/credit_vo/cast_vo.dart';
import 'package:movie_app/data/vos/credit_vo/crew_hive_vo.dart';
import 'package:movie_app/data/vos/credit_vo/crew_vo.dart';
import 'package:movie_app/data/vos/genres_vo/genres_vo.dart';
import 'package:movie_app/data/vos/movie_vo/movie_hive_vo.dart';
import 'package:movie_app/data/vos/movie_vo/result_vo.dart';
import 'package:movie_app/data/vos/productionCompanies_vo/production_companies_vo.dart';
import 'package:movie_app/network/response/actor_detail_response/actor_detail_response.dart';
import 'package:movie_app/network/response/moviedetails_response/movie_details_response.dart';
import 'package:movie_app/persistent/daos/actor_dao/actor_dao.dart';
import 'package:movie_app/persistent/daos/actor_dao/actor_dao_impl.dart';
import 'package:movie_app/persistent/daos/actor_detail_dao/actor_detail_dao.dart';
import 'package:movie_app/persistent/daos/actor_detail_dao/actor_detail_dao_impl.dart';
import 'package:movie_app/persistent/daos/cast_dao/cast_dao.dart';
import 'package:movie_app/persistent/daos/cast_dao/cast_dao_impl.dart';
import 'package:movie_app/persistent/daos/movie_dao/movie_dao.dart';
import 'package:movie_app/persistent/daos/movie_dao/movie_dao_impl.dart';
import 'package:movie_app/persistent/daos/movie_detail_dao/movie_detail_dao.dart';
import 'package:movie_app/persistent/daos/movie_detail_dao/movie_detail_dao_impl.dart';
import 'package:movie_app/persistent/daos/similar_dao/similar_dao.dart';
import 'package:movie_app/persistent/daos/similar_dao/similar_movie_impl.dart';
import 'package:stream_transform/stream_transform.dart';
import '../../constant/api_constant.dart';
import '../../network/data_agent/movie_data_agent.dart';
import '../../network/data_agent/movie_data_agent_impl.dart';
import '../../persistent/daos/crew_dao/crew_dao.dart';
import '../../persistent/daos/crew_dao/crew_dao_impl.dart';
import '../../persistent/daos/genres_dao/genres_dao.dart';
import '../../persistent/daos/genres_dao/genres_dao_impl.dart';
import '../vos/actor_vo/result_vo/actor_result_vo.dart';
import '../vos/credit_vo/cast_hive_vo.dart';
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
  final CastDAO _castDAO = CastDAOImpl();
  final CrewDAO _crewDAO = CrewDAOImpl();
  final SimilarDAO _similarDAO = SimilarMovieImpl();
  final ActorDetailDAO _actorDetailDAO = ActorDetailDAOImpl();
  ///Genres
  @override
  Future<List<GenresVO>?> getGenresList() =>
      _movieDataAgent.getGenresList().then((value) {
        if (value != null) {
          _genresDAO.save(value);
          getMovieByGenreIDList(value.first.id ?? 0);
        }
        return value;
      });

  @override
  Stream<List<GenresVO>?> getGenresListFromDataBase() => _genresDAO
      .watchBox()
      .startWith(_genresDAO.getGenresListFromDataBaseStream())
      .map((event) => _genresDAO.getGenresListFromDataBase());


  @override
  Future<List<MovieVO>?> getTopRatedMoviesList(int page) =>
      _movieDataAgent.getTopRatedMoviesList(page).then((value) {
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
  Future<List<MovieVO>?> getPopularMoviesList(int page) =>
      _movieDataAgent.getPopularMoviesList(page).then((value) {
        if (value != null) {
          value = value.map((e) {
            e.isPopularMovies = true;
            e.posterPath ?? kNullImage;
            return e;
          }).toList();

          _movieDAO.save(value);
        }
      });

  @override
  Stream<List<MovieVO>?> getPopularMoviesListFromDataBase(int page) => _movieDAO
      .watchMovieBox()
      .startWith(_movieDAO.getPopularMoviesListFromDataBaseStream(page))
      .map((event) => _movieDAO.getPopularMoviesListFromDataBase(page));

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
  Stream<List<MovieVO>?> getTopRatedMovieListFromDataBase(int page) => _movieDAO
      .watchMovieBox()
      .startWith(_movieDAO.getTopRatedFromDataBaseStream(page))
      .map((event) => _movieDAO.getTopRatedListFromDataBase(page));

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
///SimilarMovies
  @override
  Stream<MovieHiveVO?> getSimilarMovieListFromDataBase(int movieID) =>
     _similarDAO.watch()
      .startWith(_similarDAO.getMovieHiveBYStream(movieID))
      .map((event) => _similarDAO.getMovieHiveList(movieID));

  @override
  Future<List<MovieVO>?> getSimilarMoviesList(int movieID)async {
    _movieDataAgent.getSimilarMovieList(movieID).then((value) {
      var temp = value?.map((e){
         e.backdropPath==null?(e.backdropPath=kNullImage):(e.backdropPath);
         return e;
      }).toList();
     if(temp!=null){
       MovieHiveVO movieHiveVO = MovieHiveVO(resultVO: temp);
       _similarDAO.save(movieHiveVO, movieID);
     }
     return temp;
    });
  }
///Cast
  @override
  Future<List<CastVO>?> getCastList(int castID)=>
      _movieDataAgent.getCastList(castID).then((value) {
        var temp = value?.map((e){
          e.gender==1?'Female':'Male';
          return e;
        }).toList();
        if(temp!=null){
          CastHiveVO castHiveVO = CastHiveVO(temp);
          _castDAO.save(castHiveVO,castID);
        }
        return temp;
      });

  @override
  Stream<CastHiveVO?> getCastListFromDataBase(int castID) =>
      _castDAO.watchBox()
      .startWith(_castDAO.getCastDataFromStream(castID))
      .map((event) => _castDAO.getCastDataFromDatabase(castID));
///Crew
  @override
  Future<List<CrewVO>?> getCrewList(int crewID) =>
      _movieDataAgent.getCrewList(crewID).then((value) {
         var crewData = value;
        if(crewData!=null){
          CrewHiveVO crewHiveVO = CrewHiveVO(crewHiveVO: crewData);
          _crewDAO.save(crewHiveVO,crewID);
        }
        return crewData ;
      });
  @override
  Stream<CrewHiveVO?> getCrewListFromDataBase(int crewID)=>
      _crewDAO.watchBox()
      .startWith(_crewDAO.getCrewDataFromStream(crewID))
      .map((event) => _crewDAO.getCrewDataFromDatabase(crewID));

  @override
  Future<List<MovieVO>?> getSearchMoviesList(String query)=>
      _movieDataAgent.getSearchMoviesList().then((value) {
        if(value!=null){
          final temp = value;
          temp.map((e) {
            e.isSearchMovies=true;
            return e;
          }).toList();
        }
        return value;
      });

///MovieByGenre
  @override
  Stream<List<MovieVO>?> getMovieByGenreIDFromDataBase(int genreID) =>_movieDAO.watchMovieBox().
      startWith(_movieDAO.getMovieByGenreFromDataBaseStream( genreID))
      .map((event) => _movieDAO.getMovieByGenreFromDataBase(genreID));

  @override
  Future<List<MovieVO>?> getMovieByGenreIDList(int genreID) =>
      _movieDataAgent.getMoviesByGenreIDList(genreID).then((value){
        if(value!=null){
          final temp = value;
          temp.map((e) {
            e.isGetNowPlaying=true;
            return e;
          }).toList();
          _movieDAO.save(value);
        }
        return value;
      });

  @override
  Stream<ActorDetailResponse?> getActorDetailFromDataBase(int actorID)=>_actorDetailDAO
      .watchActorBox()
      .startWith(_actorDetailDAO.getActorDetailFromStream(actorID))
      .map((event) => _actorDetailDAO.getActorDetailResponse(actorID));
  @override
  Future<ActorDetailResponse?> getActorDetailResponse(int actorID) =>_movieDataAgent
      .getActorDetailList(actorID).then((value) {
    if (value != null) {
      _actorDetailDAO.saveActorData(value);
      final actorData = value;
      if (actorData.deathDay == null || actorData.deathDay == '') {
        actorData.deathDay = '-';
      }
      return actorData;
    }

    return value;
  });



}
