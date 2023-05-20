import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/constant/dimens.dart';
import 'package:movie_app/data/models/movie_model.dart';
import 'package:movie_app/data/models/movie_model_imp.dart';
import 'package:movie_app/data/vos/productionCompanies_vo/production_companies_vo.dart';
import 'package:movie_app/widgets/sliverappbar_widget.dart';
import '../constant/strings.dart';
import '../data/vos/movie_vo/result_vo.dart';
import '../widgets/lisview_image_widget.dart';
import '../widgets/stack_widget.dart';
import '../widgets/starcast_talent_widget.dart';
  final MovieModel _movieData=  MovieModelImpl();
class MovieDetailScreen extends StatelessWidget {
  const MovieDetailScreen({Key? key, this.movieID}) : super(key: key);
  final int? movieID ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SliverAppBarWidget(expandedHeight: kPS400px, centerTitle:true, dataFuture:_movieData.getMovieDetails(movieID!), builder: (context,snapShot){
        if(snapShot.connectionState == ConnectionState.waiting){
          return const Center(child: CircularProgressIndicator(color: Colors.red,),);
        }else if(snapShot.hasError){
          return  Center(child: Image.asset("images/place_holder.jpg"),);
        }else {
          final movieData = snapShot.data;
          return Hero(
              tag: 'movie_${movieData?.id}',
              child: CachedNetworkImage(imageUrl: "https://image.tmdb.org/t/p/w500/${movieData?.backdropPath}",fit: BoxFit.fill,errorWidget:(context,url,error)=>const Center(child: CircularProgressIndicator(),),));
        }
      }, textBuilder: (context,snapShot){
        if(snapShot.connectionState == ConnectionState.waiting){
          return const Center(child: Text(""));
        }else if(snapShot.hasError){
          return const Center(child: Text("errorTitle"),);
        }else {
          final movieData = snapShot.data;
          return Text("${movieData?.title}",style: const TextStyle(color: Colors.white,fontSize: 16),);
        }
      }, bodyBuilder: (context,snapShot){
        if(snapShot.connectionState == ConnectionState.waiting){
          return const Center(child: CircularProgressIndicator(color: Colors.red,),);
        }else if(snapShot.hasError){
          return const Center(child: Text("error"),);
        }else {
          final movieData = snapShot.data;
          return SingleChildScrollView(
            child: Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(
                  left: kPS10px, right: kPS10px, top: kPS20px),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    kStoryLineText,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: kPS16px,
                        color: Colors.white),
                  ),
                  const SizedBox(
                    height: kPS10px,
                  ),
                  Text(
                    "${movieData?.overview}",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white70),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(
                    height: kPS10px,
                  ),
                  const Text(
                    kStarCastText,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.white),
                  ),
                   StarCastTalentWidget(images: data,),
                  const Text(
                    kTalentSquadText,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.white),
                  ),
                   StarCastTalentWidget(images: data),
                  const Text(
                    kCompanyText,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.white),
                  ),
                 ///ProductionCompanies
                 FutureBuilder<List<ProductionCompaniesVO>?>(future: _movieData.getCompanyList(movieID!),builder: (context,snapShot){
                   if(snapShot.connectionState == ConnectionState.waiting){
                     return const Center(child: CircularProgressIndicator(color: Colors.red,),);
                   }else if(snapShot.hasError){
                     return const Center(child: Text("errorTitle"),);
                   }else {
                     final movieData = snapShot.data;
                     return SizedBox(
                       height: 150,
                       child: ListView.builder(
                         scrollDirection: Axis.horizontal,
                           itemCount: movieData?.length,itemBuilder: (context,index){
                         return Container(
                           alignment: Alignment.center,
                           width: 70,
                           margin: const EdgeInsets.all(10),
                           child: Column(
                             children: [
                               CircleAvatar(
                           backgroundColor:Colors.white,
                                 child: ClipRRect(
                                   borderRadius:BorderRadius.circular(20),
                                   child: CachedNetworkImage(
                                     width: 50,
                                     height: 50,
                                     imageUrl: "https://image.tmdb.org/t/p/w500/${movieData?[index].logoPath}",
                                   placeholder: (context,url)=> Image.asset("images/place_holder.jpg"),
                                   errorWidget: (context,url,error)=>Image.asset("images/place_holder.jpg"),),
                                 ),
                               ),
                                const SizedBox(height: 10,),
                                Expanded(child:
                                 Text("${movieData?[index].name}",style: const TextStyle(color: Colors.white),textAlign:TextAlign.center,),
                               ),
                             ],
                           ),
                         );
                       }),
                     );
                   }
                 }),
                  const Text(
                    kRecommendedText,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: kPS16px,
                        color: Colors.white),
                  ),
                  ListViewImage<MovieVO>(lisViewHeight: kPS260px,future: _movieData.getPopularMoviesList(), itemBuilder: (context,movie){
                    return  Container(
                        width: kPS180px,
                        margin: const EdgeInsets.symmetric(horizontal: kPS15px,vertical: kPS15px),
                        child: StackWidget(width: 50,imageWidth:kPS180px,imageHeight:kPS260px,imageUrl: 'https://image.tmdb.org/t/p/w500/${movie.backdropPath}', title:  movie.title ?? "", voteAverage: "${movie.voteAverage}", voteCount: "${movie.voteCount}")
                    );
                  }),
                ],
              ),
            ),
          );
        }
      }),
    );
  }
}
List<Map<String,String>> data = [

{'image':"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTqlIMgm1cc4XhUNpKjrlTkQmnifEHRGbnIhg&usqp=CAU",'name':'Chris Hemsworth','type':'Actor'},
{'image':"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTejdGW1r01LA3vzhEuGrwwIdKPiktrzi9j2A&usqp=CAU",'name':'Vijay','type':'Actor'},
{'image':"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS7e3YRZ7uc6zU4WRQK4KI_CXJSuHGA1ahgeA&usqp=CAU",'name':'Will Smith','type':'Actor'},
];