import 'package:hive/hive.dart';
import 'package:movie_app/constant/hive_constant.dart';
import 'package:movie_app/network/response/moviedetails_response/movie_details_response.dart';
import 'package:movie_app/persistent/daos/movie_detail_dao/movie_detail_dao.dart';

class MovieDetailDAOImpl extends MovieDetailResponseDAO{
  MovieDetailDAOImpl._();
  static final MovieDetailDAOImpl _singleton = MovieDetailDAOImpl._();
  factory MovieDetailDAOImpl()=>_singleton;
  @override
  MovieDetailsResponse? getMovieDetailResponseFromDataBase(int movieID) {
    final getMovie = _movieDetailBox();
    return _movieDetailBox().get(movieID);
  }


  @override
  Stream<MovieDetailsResponse?> getMovieDetailResponseFromDataBaseStream(int movieID) =>
      Stream.value(getMovieDetailResponseFromDataBase(movieID));

  @override
  void save(MovieDetailsResponse movieDetail) {
    if(movieDetail!=null){
      _movieDetailBox().put(movieDetail.id, movieDetail);
    }
  }

  @override
  Stream watchBox() =>_movieDetailBox().watch();
  Box<MovieDetailsResponse> _movieDetailBox()=>Hive.box<MovieDetailsResponse>(kBoxNameForMovieDetail);

}