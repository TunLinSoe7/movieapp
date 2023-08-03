import 'package:movie_app/data/vos/movie_vo/movie_hive_vo.dart';

abstract class SimilarDAO{
  void save(MovieHiveVO movieHiveVO,int movieID);
  MovieHiveVO? getMovieHiveList(int movieID);
  Stream watch();
  Stream<MovieHiveVO?> getMovieHiveBYStream(int movieID);
}