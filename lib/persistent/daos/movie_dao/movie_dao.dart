import 'package:movie_app/data/vos/movie_vo/result_vo.dart';

abstract class MovieDAO{
  void save(List<MovieVO> movieList);
  List<MovieVO>? getNowPlayingListFromDataBase();
  List<MovieVO>? getTopRatedListFromDataBase();
  List<MovieVO>? getPopularMoviesListFromDataBase();

  Stream<List<MovieVO>?> getNowPlayingListFromDataBaseStream();
  Stream<List<MovieVO>?> getTopRatedFromDataBaseStream();
  Stream<List<MovieVO>?>  getPopularMoviesListFromDataBaseStream();

  Stream watchMovieBox();
}