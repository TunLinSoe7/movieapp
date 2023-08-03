import 'package:movie_app/network/response/actor_detail_response/actor_detail_response.dart';

abstract class ActorDetailDAO{
  void saveActorData(ActorDetailResponse actorDetailResponse);
  ActorDetailResponse? getActorDetailResponse(int actorID);
  Stream watchActorBox();
  Stream<ActorDetailResponse?> getActorDetailFromStream(int actorID);
}