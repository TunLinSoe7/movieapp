

import 'package:flutter/material.dart';
import 'package:movie_app/data/vos/actor_vo/result_vo/actor_result_vo.dart';
import 'package:movie_app/data/vos/genres_vo/genres_vo.dart';
import '../../data/models/movie_model.dart';
import '../../data/models/movie_model_imp.dart';
import '../../data/vos/movie_vo/result_vo.dart';

class HomePageBloc extends ChangeNotifier {
  bool cir = true;
  int genreID = 12;
  bool isDispose  =false;

  final MovieModel _movieModel = MovieModelImpl();
  int _selectedIndex = 0;
  final ScrollController _scrollControllerFroPopularMovie = ScrollController();
  final ScrollController _scrollControllerForTopRated = ScrollController();
  int pageCount=1;
  int pageCountForTopRated=1;

  List<GenresVO> genreList = [];
  List<MovieVO> bannerMovieData = [];
  List<MovieVO> movieData = [];
  List<MovieVO> getMovieByGenreData = [];
  List<MovieVO> getTopRatedData = [];
  List<MovieVO> getPopularMovieData = [];
  List<ActorResultsVO> getActorData = [];
  ScrollController get getController=>_scrollControllerFroPopularMovie;
  ScrollController get getControllerForTopRated=>_scrollControllerForTopRated;
  ///Getter
  int get selectedIndex=>_selectedIndex;

  HomePageBloc() {

    ///For Genres
    _movieModel.getGenresList();
    _movieModel.getGenresListFromDataBase().listen((event) {
      genreList = event ?? [];
      notifyListeners();
    });
    ///For YouMayLikes
    _movieModel.getTopRatedMoviesList(pageCountForTopRated);
    _movieModel.getTopRatedMovieListFromDataBase(pageCountForTopRated).listen((event) {
      getTopRatedData = event ?? [];
      notifyListeners();

    });
    _scrollControllerForTopRated.addListener(() {
      if(_scrollControllerForTopRated.position.atEdge){
        pageCountForTopRated++;
        final pixel = _scrollControllerForTopRated.position.pixels;
        if(pixel!=0){
          _movieModel.getTopRatedMoviesList(pageCountForTopRated);
          notifyListeners();
        }
      }
    });
    ///For PopularMovies
    _movieModel.getPopularMoviesList(pageCount);
    _movieModel.getPopularMoviesListFromDataBase(pageCount).listen((event) {
      if(event!=null){
        getPopularMovieData = event;
        notifyListeners();
      }

    });
     _scrollControllerFroPopularMovie.addListener(() {
          if (_scrollControllerFroPopularMovie.position.atEdge) {
            pageCount++;
            final pixel = _scrollControllerFroPopularMovie.position.pixels;
            if (pixel != 0) {
              _movieModel.getPopularMoviesList(pageCount);
             cir=false;
            }
          }
        });


    ///For ActorMovies
    _movieModel.getActorList();
    _movieModel.getActorListFromDataBase().listen((event) {
      getActorData = event ?? [];
      notifyListeners();
    });
///Listen Movie By Genre ID FromDatabase
    _movieModel.getMovieByGenreIDFromDataBase(genreID).listen((event) {
      if(event!=null && event.isNotEmpty){
        bannerMovieData =event.take(5).toList();
      }
      notifyListeners();
    });
    _movieModel.getMovieByGenreIDFromDataBase(genreID).listen((event) {
      if(event!=null && event.isNotEmpty){
        movieData =event;
      }
      notifyListeners();
    });

  }
  void getData(int genreID){
    _movieModel.getMovieByGenreIDList(genreID);
    notifyListeners();
  }
   void increase(index){
    _selectedIndex=index;
    notifyListeners();
   }

  @override
  void dispose() {
    isDispose = true;
    _scrollControllerFroPopularMovie.dispose();
    _scrollControllerForTopRated.dispose();
    super.dispose();
  }
  @override
  void notifyListeners() {
    if(!isDispose){
      super.notifyListeners();
    }

  }
}
