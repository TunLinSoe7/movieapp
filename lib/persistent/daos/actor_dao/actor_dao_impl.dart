import 'package:hive/hive.dart';
import 'package:movie_app/constant/hive_constant.dart';
import 'package:movie_app/data/vos/actor_vo/result_vo/actor_result_vo.dart';
import 'package:movie_app/persistent/daos/actor_dao/actor_dao.dart';

class ActorDAOImpl extends ActorDAO{
  ActorDAOImpl._();
  static final ActorDAOImpl _singleton = ActorDAOImpl._();
  factory ActorDAOImpl()=>_singleton;
  @override
  List<ActorResultsVO>? getActorResultsVOFromDatabase() =>_actorBox().values.toList();

  @override
  Stream<List<ActorResultsVO>?> getActorResultsVOFromDatabaseFromStream() => Stream.value(getActorResultsVOFromDatabase());

  @override
  void save(List<ActorResultsVO> actor) {
    for(ActorResultsVO actorResultsVO in actor){
      if(actor!=null){
        _actorBox().put(actorResultsVO.id, actorResultsVO);
      }
    }
  }

  @override
  Stream watchBox()=>
  _actorBox().watch();

        Box<ActorResultsVO> _actorBox()=> Hive.box<ActorResultsVO>(kBoxNameForActorVO);

}