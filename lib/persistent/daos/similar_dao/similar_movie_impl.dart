import 'package:hive/hive.dart';
import 'package:movie_app/constant/hive_constant.dart';
import 'package:movie_app/data/vos/movie_vo/movie_hive_vo.dart';
import 'package:movie_app/persistent/daos/similar_dao/similar_dao.dart';

class SimilarMovieImpl extends SimilarDAO{
  SimilarMovieImpl._();
  static final SimilarMovieImpl _singleton= SimilarMovieImpl._();
  factory SimilarMovieImpl()=>_singleton;

  @override
  Stream<MovieHiveVO?> getMovieHiveBYStream(int movieID) =>Stream.value(getMovieHiveList(movieID));

  @override
  MovieHiveVO? getMovieHiveList(int movieID) =>_box().get(movieID);
  @override
  void save(MovieHiveVO movieHiveVO,int movieID) {
    if(movieHiveVO!=null){
      _box().put(movieID, movieHiveVO);
    }
  }

  @override
  Stream watch() =>_box().watch();
  Box<MovieHiveVO> _box()=>Hive.box(kBoxNameForMovieHiveType);
}