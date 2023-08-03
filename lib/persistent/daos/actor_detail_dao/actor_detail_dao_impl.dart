import 'package:hive/hive.dart';
import 'package:movie_app/constant/hive_constant.dart';
import 'package:movie_app/network/response/actor_detail_response/actor_detail_response.dart';
import 'package:movie_app/persistent/daos/actor_detail_dao/actor_detail_dao.dart';

class ActorDetailDAOImpl extends ActorDetailDAO{
  ActorDetailDAOImpl._();
  static final ActorDetailDAOImpl _singleton = ActorDetailDAOImpl._();
  factory ActorDetailDAOImpl()=>_singleton;

  @override
  Stream<ActorDetailResponse?> getActorDetailFromStream(int actorID)=>Stream.value(getActorDetailResponse(actorID));

  @override
  ActorDetailResponse? getActorDetailResponse(int actorID)=>_actorBox().get(actorID);

  @override
  void saveActorData(ActorDetailResponse actorDetailResponse) =>
      _actorBox().put(actorDetailResponse.id, actorDetailResponse);
  @override
  Stream watchActorBox()=>_actorBox().watch();
  Box<ActorDetailResponse> _actorBox()=>Hive.box(kBoxNameForActorDetail);
}