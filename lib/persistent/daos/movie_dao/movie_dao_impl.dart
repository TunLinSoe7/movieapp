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
  void save(List<MovieVO> movieList) {
    for(MovieVO movieVO in movieList){
      _movieBox().put(movieVO.id, movieVO);
    }
  }

  ///Get Now Playing
  @override
  List<MovieVO>? getNowPlayingListFromDataBase() {
   final getMovies = _movieBox().values.toList();
return getMovies.where((element) => element.isGetNowPlaying ?? false)
    .toList();
  }

  @override
  Stream<List<MovieVO>?> getNowPlayingListFromDataBaseStream() =>Stream.value(getNowPlayingListFromDataBase());


///TopRatedMovies
  @override
  List<MovieVO>? getTopRatedListFromDataBase() {
    final getTopRatedMovies = _movieBox().values.toList();
    return getTopRatedMovies.where((element) => element.isTopRated ?? false).toList();
  }

  @override
  Stream<List<MovieVO>?> getTopRatedFromDataBaseStream() =>
      Stream.value(getTopRatedListFromDataBase());
///Popular Movies
  @override
  List<MovieVO>? getPopularMoviesListFromDataBase() {
   final getPopularMovies = _movieBox().values.toList();
   return getPopularMovies.where((element) => element.isPopularMovies ?? false).toList();
  }

  @override
  Stream<List<MovieVO>?> getPopularMoviesListFromDataBaseStream() =>
      Stream.value(getPopularMoviesListFromDataBase());
}