import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/data/vos/actor_vo/result_vo/actor_result_vo.dart';
import 'package:movie_app/pages/actor_details.dart';
import 'package:movie_app/pages/movie_details.dart';
import 'package:movie_app/widgets/carousel_stack_widget.dart';
import 'package:movie_app/widgets/carousel_widget.dart';
import 'package:movie_app/widgets/lisview_image_widget.dart';
import 'package:movie_app/widgets/stack_widget.dart';
import '../constant/assest_images.dart';
import '../constant/dimens.dart';
import '../constant/strings.dart';
import '../data/models/movie_model.dart';
import '../data/models/movie_model_imp.dart';
import '../data/vos/genres_vo/genres_vo.dart';
import '../data/vos/movie_vo/result_vo.dart';
final MovieModel _movieModel = MovieModelImpl();

class HomePage extends StatefulWidget {


  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;


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
              child: FutureBuilder<List<GenresVO>?>(
                future: _movieModel.getGenresList(),
                builder: (context, snapShot) {
                  if (snapShot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapShot.hasError) {
                    return const Center(
                      child: Text("Error"),
                    );
                  } else {
                    final genreData = snapShot.data;
                    return ListView.separated(
                        separatorBuilder: (context, index) => const SizedBox(
                              width: kPS10px,
                            ),
                        scrollDirection: Axis.horizontal,
                        itemCount: genreData!.length,
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
                              child: Text(
                               "${genreData?[index].name}",
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                            ),
                          );
                        });
                  }
                },
              ),
            ),
            const SizedBox(
              height: kPS15px,
            ),
            const SizedBox(
              height: kPS20px,
            ),
            /// BannerImage
          CarouselImage<MovieVO>(future: _movieModel.getMoviesList(), dataLimit: 5,itemBuilder: (context,movieData){
            return Hero(
              tag: 'movie_${movieData.id}',
              child: CarouselStackWidget(imagerUrl: "https://image.tmdb.org/t/p/w500/${movieData.posterPath}", imageHeight: 400, imageWidth: MediaQuery.of(context).size.width*0.8,decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
                  Colors.transparent,
                  Colors.black
                ],begin: Alignment.topCenter,end: Alignment.bottomCenter),
              ),onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=> MovieDetailScreen(movieID: movieData.id,)));
              },),
            );
          }),
             ListViewImage<MovieVO>(lisViewHeight: 200,future: _movieModel.getMoviesList(), itemBuilder: (context,movie){
                return Container(
                   width: kPS260px,
                   margin: const EdgeInsets.symmetric(horizontal: kPS15px,vertical: kPS15px),
                   child: StackWidget(width: 100,imageWidth:kPS260px,imageHeight:kPS200px,imageUrl: 'https://image.tmdb.org/t/p/w500/${movie?.backdropPath}', title:  movie?.title ?? "", voteAverage: "${movie?.voteAverage}", voteCount: "${movie?.voteCount}")
               );
             },),
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
           ListViewImage<MovieVO>(lisViewHeight: kPS260px,future: _movieModel.getTopRatedMoviesList(), itemBuilder: (context,movie){
             return  Container(
                 width: kPS180px,
                 margin: const EdgeInsets.symmetric(horizontal: kPS15px,vertical: kPS15px),
                 child: StackWidget(width: 50,imageWidth:kPS180px,imageHeight:kPS260px,imageUrl: 'https://image.tmdb.org/t/p/w500/${movie?.backdropPath}', title:  movie?.title ?? "", voteAverage: "${movie?.voteAverage}", voteCount: "${movie?.voteCount}")
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
            ListViewImage<MovieVO>(lisViewHeight: kPS260px,future: _movieModel.getPopularMoviesList(), itemBuilder: (context,movie){
              return  Container(
                  width: kPS180px,
                  margin: const EdgeInsets.symmetric(horizontal: kPS15px,vertical: kPS15px),
                  child: StackWidget(width: 50,imageWidth:kPS180px,imageHeight:kPS260px,imageUrl: 'https://image.tmdb.org/t/p/w500/${movie?.backdropPath}', title:  movie?.title ?? "", voteAverage: "${movie?.voteAverage}", voteCount: "${movie?.voteCount}")
              );
            }),

            ///Actor image slider
            CarouselImage<ActorResultsVO>(future:_movieModel.getActorList() , itemBuilder: (context,movie){
              return Hero(
                tag: "actor_${movie.id}",
                child: CarouselStackWidget(name:movie.name,showCircleAvatar: false,showActorName: true,imagerUrl: "https://image.tmdb.org/t/p/w500/${movie.profilePath}", imageHeight: 400, imageWidth: MediaQuery.of(context).size.width*0.8,decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Colors.transparent,
                    Colors.black
                  ],begin: Alignment.topCenter,end: Alignment.bottomCenter),
                ),onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ActorDetailScreen(actorID: movie.id,)));
                },),
              );
            }),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}


