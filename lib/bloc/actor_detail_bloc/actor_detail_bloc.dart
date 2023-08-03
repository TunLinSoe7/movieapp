import 'package:flutter/material.dart';
import 'package:movie_app/data/models/movie_model.dart';
import 'package:movie_app/data/models/movie_model_imp.dart';
import '../../network/response/actor_detail_response/actor_detail_response.dart';

class ActorDetailBloc extends ChangeNotifier{
  bool isDispose = false;
  final MovieModel _movieModel = MovieModelImpl();
  ActorDetailResponse? actorDetailResponse;
  ActorDetailBloc(int actorID){
    _movieModel.getActorDetailResponse(actorID);
    _movieModel.getActorDetailFromDataBase(actorID).listen((event) {
      if(event!=null){
        actorDetailResponse = event;
      }
      notifyListeners();
    });
  }
  @override
  void dispose() {
    isDispose =true;
    super.dispose();
  }
  @override
  void notifyListeners() {
   if(!isDispose){
     super.notifyListeners();
   }
  }
}