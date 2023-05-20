import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../constant/dimens.dart';
import '../constant/strings.dart';
import '../data/models/movie_model.dart';
import '../data/models/movie_model_imp.dart';
import '../data/vos/movie_vo/result_vo.dart';
import '../widgets/lisview_image_widget.dart';
import '../widgets/sliverappbar_widget.dart';
import '../widgets/stack_widget.dart';
import '../widgets/table_row_widget.dart';
MovieModel _movieModel = MovieModelImpl();
class ActorDetailScreen extends StatelessWidget {
  const ActorDetailScreen({Key? key,  this.actorID}) : super(key: key);
  final int? actorID;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SliverAppBarWidget(expandedHeight: 400, centerTitle: true, dataFuture: _movieModel.getActorDetailList(actorID!), builder:(context,snapShot){
        if(snapShot.connectionState == ConnectionState.waiting){
          return const Center(child: CircularProgressIndicator(color: Colors.red,),);
        }else if(snapShot.hasError){
          return const Center(child: Text("error"),);
        }else {
          final actorData = snapShot.data;
          return Hero(
              tag: "actor_${actorData?.id}",
              child: CachedNetworkImage(imageUrl: "https://image.tmdb.org/t/p/w500/${actorData?.profilePath}",fit: BoxFit.fill,errorWidget:(context,url,error)=>Center(child: CircularProgressIndicator(),),));
        }
      }, textBuilder: (BuildContext context, snapshot) {
    if(snapshot.connectionState == ConnectionState.waiting){
    return const Center(child: Text(""));
    }else if(snapshot.hasError){
    return const Center(child: Text("error"),);
    }else {
      return Text("${snapshot.data?.name}",style: const TextStyle(color: Colors.white),);
    }

      }, bodyBuilder: (BuildContext context, snapShot) {
        if(snapShot.connectionState == ConnectionState.waiting){
          return const Center(child: CircularProgressIndicator(color: Colors.red,),);
        }else if(snapShot.hasError){
          return const Center(child: Text("error"),);
        }else {
          final actor = snapShot.data;
          return SingleChildScrollView(
            child: Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: kPS10px,right: kPS10px,top: kPS20px),
              child:  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:[
                  const Text(kBiographyText,style: TextStyle(fontWeight: FontWeight.bold,fontSize: kPS16px,color: Colors.white),),
                  const Divider(color: Colors.white,thickness: 2,),
                  const SizedBox(height: kPS10px,),
                   Text(actor?.biography ?? '',
                    style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.white70),textAlign: TextAlign.justify,),
                  const SizedBox(height: kPS10px,),
                  const Text(kMoreInfoText,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: Colors.white),),
                  const Divider(color: Colors.white,thickness: 2,),
                   CustomTable(
                    data: [
                      ['Place Of Birth','${actor?.placeOfBirth}'],
                      ['BirthDay','${actor?.birthday}'],
                      ['DeadDay','${actor?.deathDay}'],
                      ['Gender',(actor?.gender == 1?'female':'male')],
                      ['Popularity','${actor?.popularity}'],
                    ],
                  ),
                  const SizedBox(height: kPS15px,),
                  /// KnowFor
                  const Text(kKnowForText,style: TextStyle(fontWeight: FontWeight.bold,fontSize: kPS16px,color: Colors.white),),
                  ListViewImage<MovieVO>(lisViewHeight: kPS260px,future: _movieModel.getPopularMoviesList(), itemBuilder: (context,movie){
                    return  Container(
                        width: kPS180px,
                        margin: const EdgeInsets.symmetric(horizontal: kPS15px,vertical: kPS15px),
                        child: StackWidget(width: 50,imageWidth:kPS180px,imageHeight:kPS260px,imageUrl: 'https://image.tmdb.org/t/p/w500/${movie?.backdropPath}', title:  movie?.title ?? "", voteAverage: "${movie?.voteAverage}", voteCount: "${movie?.voteCount}")
                    );
                  }),
                ],),
            ),
          );
        }
      } ,)
    );
  }
}
