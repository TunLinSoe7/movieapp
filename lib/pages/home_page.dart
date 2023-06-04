import 'package:flutter/material.dart';
import 'package:movie_app/data/vos/actor_vo/result_vo/actor_result_vo.dart';
import 'package:movie_app/pages/actor_details.dart';
import 'package:movie_app/pages/movie_details.dart';
import 'package:movie_app/widgets/carousel_stack_widget.dart';
import 'package:movie_app/widgets/carousel_widget.dart';
import 'package:movie_app/widgets/lisview_image_widget.dart';
import 'package:movie_app/widgets/stack_widget.dart';
import '../constant/dimens.dart';
import '../constant/strings.dart';
import '../data/models/movie_model.dart';
import '../data/models/movie_model_imp.dart';
import '../data/vos/genres_vo/genres_vo.dart';
import '../data/vos/movie_vo/result_vo.dart';

class HomePage extends StatefulWidget {

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {
  final MovieModel _movieModel = MovieModelImpl();
  int selectedIndex = 0;
  List<MovieVO>? movieItems;
  List<MovieVO>? movieData;
  List<MovieVO>? movie;
  List<GenresVO>? categories;
  List<ActorResultsVO>? actorData;
  @override
  void initState() {
    ///Categories
    _movieModel.getGenresList().then((value) {
     setState(() {
       categories = value;
     });
    }).catchError((error)=> print(error));
    ///Banner Image
    _movieModel.getMoviesList().then((value) {
     setState(() {
       movieItems = value;
     });
    }).catchError((error)=>null);

    ///You May Like

    _movieModel.getTopRatedMoviesList().then((value) {
      setState(() {
        movieData = value;
      });
    }).catchError((error)=>print(error.toString()));
    ///Popular
    _movieModel.getPopularMoviesList().then((value) {
      setState(() {
        movie = value;
      });
    }).catchError((error)=>print(error.toString()));
    ///Banner Image
    _movieModel.getActorList().then((value) {
      setState(() {
        actorData = value;
      });
    }).catchError((error)=>print(error.toString()));
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: kPS80px,
            ),

            /// Search Bar
            Row(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: kPS10px),
                  margin: const EdgeInsets.only(left: kPS10px, right: kPS10px),
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(kPS10px)),
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: kPS50px,
                  child: const Text(
                    kSearchBarText,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const Spacer(),
                Container(
                  margin: const EdgeInsets.only(right: kPS10px),
                  decoration: BoxDecoration(
                      color: Colors.redAccent.shade100,
                      borderRadius: BorderRadius.circular(kPS10px)),
                  width: kPS40px,
                  height: kPS40px,
                  child: const Icon(
                    Icons.search_rounded,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: kPS20px,
            ),

            /// Categories
            SizedBox(
              width: double.infinity,
              height: kPS40px,
              child:  categories=="" || categories ==null?const Center(child: CircularProgressIndicator(color: Colors.red,)):ListView.separated(
                  separatorBuilder: (context, index) => const SizedBox(
                    width: kPS10px,
                  ),
                  scrollDirection: Axis.horizontal,
                  itemCount: categories?.length ?? 0,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(kPS8px),
                        margin: const EdgeInsets.symmetric(
                            horizontal: kPS10px),
                        decoration: BoxDecoration(
                            color: selectedIndex == index
                                ? Colors.redAccent
                                : null,
                            borderRadius: BorderRadius.circular(5)),
                        child: categories == null ? const CircularProgressIndicator(color: Colors.red,):Text(
                          "${categories?[index].name}",
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ),
                    );
                  })
            ),
            const SizedBox(
              height: kPS15px,
            ),
            const SizedBox(
              height: kPS20px,
            ),
            /// BannerImage

            movieItems=="" || movieItems ==null?  Center(child: Container(
           margin: const EdgeInsets.only(bottom: 200,top: 70),
             child: const CircularProgressIndicator(color: Colors.red,))):
            CarouselSliderWidget(autoPlay: true,itemCount: movieItems?.take(5).length ?? 0, itemBuilder: (context,index){
            return Hero(
              tag: 'movie_${movieItems?[index].id}',
              child: CarouselStackWidget(imagerUrl: 'https://image.tmdb.org/t/p/w500/${movieItems?[index].posterPath}', imageHeight: kPS400px, imageWidth: MediaQuery.of(context).size.width*0.8,
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=> MovieDetailScreen(movieID: movieItems?[index].id,)));
              },decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black
                    ]
                  )
                ),),
            );
          },),
            movieItems=="" || movieItems ==null?const Center(child: CircularProgressIndicator(color: Colors.red,)):
            ListViewImageWidget(listViewHeight: kPS200px, itemCount:movieItems?.length ?? 0, itemBuilder: (context,index){
                return Container(
                    width: kPS260px,
                    margin: const EdgeInsets.symmetric(
                        horizontal: kPS15px, vertical: kPS15px),
                    child: StackWidget(width: 100,
                        imageWidth: kPS260px,
                        imageHeight: kPS200px,
                        imageUrl: 'https://image.tmdb.org/t/p/w500/${movieItems?[index]
                            .backdropPath}',
                        title: movieItems?[index].title ?? "",
                        voteAverage: "${movieItems?[index].voteAverage}",
                        voteCount: "${movieItems?[index].voteCount}")
                );
            }),
            ///You May Like images
            Container(
                margin: const EdgeInsets.all(kPS15px),
                alignment: Alignment.centerLeft,
                child: const Text(
                  kYouMayLikeText,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.white),
                )),
            movieData=="" || movieData ==null?const Center(child: CircularProgressIndicator(color: Colors.red,)):ListViewImageWidget(listViewHeight: kPS260px, itemCount: movieData?.length ?? 0, itemBuilder:(context,index){
              return  Container(
                  width: kPS180px,
                  margin: const EdgeInsets.symmetric(horizontal: kPS15px,vertical: kPS15px),
                  child: StackWidget(width: 50,imageWidth:kPS180px,imageHeight:kPS260px,imageUrl: 'https://image.tmdb.org/t/p/w500/${movieData?[index].backdropPath}', title:  movieData?[index].title ?? "", voteAverage: "${movieData?[index].voteAverage}", voteCount: "${movieData?[index].voteCount}")
              );
            }),

            ///Popular
             Container(
                margin: const EdgeInsets.all(kPS15px),
                alignment: Alignment.centerLeft,
                child: const Text(
                  kPopularText,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: kPS18px,
                      color: Colors .white),
                )),

            const SizedBox(
              height: kPS10px,
            ),
            movie=="" || movie ==null?const Center(child: CircularProgressIndicator(color: Colors.red,)):
            ListViewImageWidget(listViewHeight: kPS260px, itemCount: movie?.length ?? 0, itemBuilder:(context,index){
              return  Container(
                  width: kPS180px,
                  margin: const EdgeInsets.symmetric(horizontal: kPS15px,vertical: kPS15px),
                  child: StackWidget(width: 50,imageWidth:kPS180px,imageHeight:kPS260px,imageUrl: 'https://image.tmdb.org/t/p/w500/${movie?[index].backdropPath}', title:  movie?[index].title ?? "", voteAverage: "${movie?[index].voteAverage}", voteCount: "${movieData?[index].voteCount}")
              );
            }),


            ///Actor image slider
            actorData== null|| actorData==""?const Center(child: CircularProgressIndicator(color: Colors.red,)):CarouselSliderWidget(autoPlay:false,itemCount: actorData?.length ?? 0, itemBuilder: (context,index){
              return Hero(
                tag: 'movie_${actorData?[index].id}',
                child: actorData == null ? const CircularProgressIndicator(color: Colors.red,):CarouselStackWidget(showCircleAvatar: false,imagerUrl: 'https://image.tmdb.org/t/p/w500/${actorData?[index].profilePath}', imageHeight: kPS400px, imageWidth: MediaQuery.of(context).size.width*0.8,
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ActorDetailScreen(actorID: actorData?[index].id,)));
                  },decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black
                          ]
                      )
                  ),),
              );
            },),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}


