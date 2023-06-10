import '../../../data/vos/actor_vo/result_vo/actor_result_vo.dart';

abstract class ActorDAO{
  void save(List<ActorResultsVO> actor);
  List<ActorResultsVO>? getActorResultsVOFromDatabase();

  Stream watchBox();
  Stream<List<ActorResultsVO>?> getActorResultsVOFromDatabaseFromStream();
}