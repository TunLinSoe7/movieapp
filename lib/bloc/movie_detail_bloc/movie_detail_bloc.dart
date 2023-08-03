import 'package:flutter/foundation.dart';
import 'package:movie_app/data/models/movie_model.dart';
import 'package:movie_app/data/models/movie_model_imp.dart';
import 'package:movie_app/data/vos/credit_vo/crew_hive_vo.dart';
import 'package:movie_app/data/vos/movie_vo/movie_hive_vo.dart';
import 'package:movie_app/data/vos/productionCountries_vo/production_countries_vo.dart';
import '../../data/vos/credit_vo/cast_hive_vo.dart';
import '../../data/vos/movie_vo/result_vo.dart';
import '../../network/response/moviedetails_response/movie_details_response.dart';


class MovieDetailBloc extends ChangeNotifier{
  bool isDispose = false;
  final MovieModel _movieModel = MovieModelImpl();
  MovieDetailsResponse? movieDetailData;
  MovieDetailsResponse? movieData;
  MovieHiveVO? similarMovieData;
  CastHiveVO? castHiveVO;
  CrewHiveVO? crewHiveData;
  List<ProductionCountriesVO>? companyData = [];
  MovieDetailBloc(int movieID){
    ///MovieDetails
    _movieModel.getMovieDetails(movieID);
    _movieModel.getMovieDetailListFromDataBase(movieID).listen((event) {
      if(event!=null){
        movieDetailData = event;
        movieData = event;
      }
      notifyListeners();
    });
    ///SimilarMovies
    _movieModel.getSimilarMoviesList(movieID);
    _movieModel.getSimilarMovieListFromDataBase(movieID).listen((event) {
      if(event!=null){
        similarMovieData =event;
      }
    });
    ///Cast
    _movieModel.getCastList(movieID);
    _movieModel.getCastListFromDataBase(movieID).listen((event) {
      final temp = event;
      if(temp!=null){
        castHiveVO = event;
      }
      notifyListeners();
    });
    ///Crew
    _movieModel.getCrewList(movieID);
    _movieModel.getCrewListFromDataBase(movieID).listen((event) {
      var temp = event;
      if(temp!=null){
        crewHiveData = temp;
      }
      notifyListeners();

    }
    );

  }
  @override
  void dispose() {
    isDispose = true;
    super.dispose();
  }
  @override
  void notifyListeners() {
    if(!isDispose){
      super.notifyListeners();
    }
  }
}
