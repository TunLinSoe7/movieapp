import 'package:hive/hive.dart';
import 'package:movie_app/constant/hive_constant.dart';
import 'package:movie_app/data/vos/movie_vo/result_vo.dart';
import 'package:movie_app/persistent/daos/movie_dao/movie_dao.dart';

class MovieDAOImpl extends MovieDAO{
  MovieDAOImpl._();
  static final MovieDAOImpl _singleton = MovieDAOImpl._();
  factory MovieDAOImpl()=>_singleton;
  @override
  Stream watchMovieBox() =>_movieBox().watch();
  Box<MovieVO> _movieBox ()=>Hive.box<MovieVO>(kBoxNameForMovieVO);

  @override
  void save(List<MovieVO>? movieList) {
    for(MovieVO movieVO in movieList!){
      _movieBox().put(movieVO.id, movieVO);
    }
  }

///TopRatedMovies
  @override
  List<MovieVO>? getTopRatedListFromDataBase(int page) {
    final getTopRatedMovies = _movieBox().values.toList();
    return getTopRatedMovies.where((element) => element.isTopRated ?? false).toList();
  }

  @override
  Stream<List<MovieVO>?> getTopRatedFromDataBaseStream(int page) =>
      Stream.value(getTopRatedListFromDataBase(page));
///Popular Movies
  @override
  List<MovieVO>? getPopularMoviesListFromDataBase(int page) {
   final getPopularMovies = _movieBox().values.toList();
   return getPopularMovies.where((element) => element.isPopularMovies ?? false).toList();
  }

  @override
  Stream<List<MovieVO>?> getPopularMoviesListFromDataBaseStream(int page) =>
      Stream.value(getPopularMoviesListFromDataBase(page));
// ///Similar Movies
//   @override
//   List<MovieVO>? getSimilarMoviesListFromDataBase() {
//     final getSimilarMovies = _movieBox().values.toList();
//     return getSimilarMovies.where((element) =>element.isSimilarMovies ??false ).toList();
//   }
//
//   @override
//   Stream<List<MovieVO>?> getSimilarMoviesListFromDataBaseStream() =>
//       Stream.value(getSimilarMoviesListFromDataBase());
///Search
  @override
  List<MovieVO>? getSearchMoviesListFromDataBase(String query) {
    final getSearchMovies = _movieBox().values.toList();
    return getSearchMovies.where((element) {
      return element.isSearchMovies ?? false ;
    }).toList();
  }

  @override
  Stream<List<MovieVO>?> getSearchMoviesListFromDataBaseStream(String query) =>Stream.value(getSearchMoviesListFromDataBase(query));
///Movie By Genre
  @override
  List<MovieVO>? getMovieByGenreFromDataBase(int genreID) {
    final getMovies = _movieBox().values.toList();
    return getMovies.where((element) {
      return element.isGetNowPlaying ?? false;
    }).toList();
  }

  @override
  Stream<List<MovieVO>?> getMovieByGenreFromDataBaseStream(int genreID) =>Stream.value(getMovieByGenreFromDataBase(genreID));
}