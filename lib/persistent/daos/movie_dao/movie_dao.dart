import 'package:movie_app/data/vos/movie_vo/result_vo.dart';

abstract class MovieDAO{
  void save(List<MovieVO>? movieList);
  List<MovieVO>? getTopRatedListFromDataBase(int page);
  List<MovieVO>? getPopularMoviesListFromDataBase(int page);
  List<MovieVO>? getSearchMoviesListFromDataBase(String query);
  List<MovieVO>? getMovieByGenreFromDataBase(int genreID);

  Stream<List<MovieVO>?> getTopRatedFromDataBaseStream(int page);
  Stream<List<MovieVO>?>  getPopularMoviesListFromDataBaseStream(int page);
  Stream<List<MovieVO>?>  getSearchMoviesListFromDataBaseStream(String query);
  Stream<List<MovieVO>?> getMovieByGenreFromDataBaseStream(int genreID);

  Stream watchMovieBox();
}