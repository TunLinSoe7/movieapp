import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import '../../data/models/movie_model.dart';
import '../../data/models/movie_model_imp.dart';
import '../../data/vos/movie_vo/result_vo.dart';

class SearchPageBloc extends ChangeNotifier{
  final MovieModel _movieModel = MovieModelImpl();
  bool _isVisible=false;
  final TextEditingController _controller = TextEditingController();
  List<MovieVO>? searchData;
  bool isDispose= false;
  get getController=>_controller;
  get getVisible=>_isVisible;
  @override
  void dispose() {
    isDispose = true;
    _controller.dispose();
    super.dispose();
  }
  @override
  void notifyListeners() {
    if(!isDispose){
      super.notifyListeners();
    }
  }
 void searchMovies(String query){
      _movieModel.getSearchMoviesList(query).then((value) {
        if (value != null) {
          searchData = value;
        }
        notifyListeners();
      });
    }

}