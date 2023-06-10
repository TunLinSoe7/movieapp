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

  List<GenresVO> _getGenresList = [];
  List<MovieVO> _getNowPlayingMovieList = [];
  List<MovieVO> _getTopRatedMovieList = [];
  List<MovieVO> _getPopularMovieList = [];
  List<ActorResultsVO> _getActorList = [];
  @override
  void initState() {

    ///Categories
    _movieModel.getGenresList();
    _movieModel.getGenresListFromDataBase().listen((event) {
      if(mounted){
        setState(() {
          _getGenresList = event ?? [] ;
        });
      }
    });
    ///Banner Image
    _movieModel.getMoviesList();
    _movieModel.getMovieListFromDataBase().listen((event) {
      if(mounted){
        setState(() {
          var temp =event ?? [];
          _getNowPlayingMovieList = temp.take(5).toList();
        });
      }
    });

    ///You May Like

    _movieModel.getTopRatedMoviesList();
    _movieModel.getTopRatedMovieListFromDataBase().listen((event) {
      if(mounted){
        setState(() {
          _getTopRatedMovieList = event ?? [];
        });
      }
    });
    ///Popular
    _movieModel.getPopularMoviesList();
    _movieModel.getPopularMoviesListFromDataBase().listen((event) {
      if(mounted){
        setState(() {
          _getPopularMovieList= event ?? [];
        });
      }
    });
    ///Actor Image
    _movieModel.getActorList();
    _movieModel.getActorListFromDataBase().listen((event) {
      if(mounted){
        setState(() {
          _getActorList = event ?? [];
        });
      }
    });
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
              child:  _getGenresList.isEmpty ?const Center(child: CircularProgressIndicator(color: Colors.red,)):ListView.separated(
                  separatorBuilder: (context, index) => const SizedBox(
                    width: kPS10px,
                  ),
                  scrollDirection: Axis.horizontal,
                  itemCount: _getGenresList.length ?? 0,
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
                        child: _getGenresList == null ? const CircularProgressIndicator(color: Colors.red,):Text(
                          "${_getGenresList?[index].name}",
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
            /// GetNowPlayingMovies

            _getNowPlayingMovieList.isEmpty || _getNowPlayingMovieList ==null?  Center(child: Container(
           margin: const EdgeInsets.only(bottom: 200,top: 70),
             child: const CircularProgressIndicator(color: Colors.red,))):
            CarouselSliderWidget(autoPlay: true,itemCount: _getNowPlayingMovieList?.take(5).length ?? 0, itemBuilder: (context,index){
            return Hero(
              tag: 'movie_${_getPopularMovieList[index].id}',
              child: CarouselStackWidget(imagerUrl: 'https://image.tmdb.org/t/p/w500/${_getNowPlayingMovieList?[index].posterPath}', imageHeight: kPS400px, imageWidth: MediaQuery.of(context).size.width*0.8,
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=> MovieDetailScreen(movieID: _getNowPlayingMovieList?[index].id,)));
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
          }, enableInfiniteScroll: true,),
            _getNowPlayingMovieList.isEmpty || _getNowPlayingMovieList ==null?const Center(child: CircularProgressIndicator(color: Colors.red,)):
            ListViewImageWidget(listViewHeight: kPS200px, itemCount:_getNowPlayingMovieList?.length ?? 0, itemBuilder: (context,index){
                return Container(
                    width: kPS260px,
                    margin: const EdgeInsets.symmetric(
                        horizontal: kPS15px, vertical: kPS15px),
                    child: StackWidget(width: 100,
                        imageWidth: kPS260px,
                        imageHeight: kPS200px,
                        imageUrl: 'https://image.tmdb.org/t/p/w500/${_getNowPlayingMovieList?[index]
                            .backdropPath}',
                        title: _getNowPlayingMovieList?[index].title ?? "",
                        voteAverage: "${_getNowPlayingMovieList?[index].voteAverage}",
                        voteCount: "${_getNowPlayingMovieList?[index].voteCount}")
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
            _getTopRatedMovieList.isEmpty || _getTopRatedMovieList ==null?const Center(child: CircularProgressIndicator(color: Colors.red,)):ListViewImageWidget(listViewHeight: kPS260px, itemCount: _getTopRatedMovieList?.length ?? 0, itemBuilder:(context,index){
              return  Container(
                  width: kPS180px,
                  margin: const EdgeInsets.symmetric(horizontal: kPS15px,vertical: kPS15px),
                  child: StackWidget(width: 50,imageWidth:kPS180px,imageHeight:kPS260px,imageUrl: 'https://image.tmdb.org/t/p/w500/${_getTopRatedMovieList?[index].backdropPath}', title:  _getTopRatedMovieList?[index].title ?? "", voteAverage: "${_getTopRatedMovieList?[index].voteAverage}", voteCount: "${_getTopRatedMovieList?[index].voteCount}")
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
            _getPopularMovieList.isEmpty|| _getPopularMovieList==null?const Center(child: CircularProgressIndicator(color: Colors.red,)):
            ListViewImageWidget(listViewHeight: kPS260px, itemCount: _getPopularMovieList?.length ?? 0, itemBuilder:(context,index){
              return  Container(
                  width: kPS180px,
                  margin: const EdgeInsets.symmetric(horizontal: kPS15px,vertical: kPS15px),
                  child: StackWidget(width: 50,imageWidth:kPS180px,imageHeight:kPS260px,imageUrl: 'https://image.tmdb.org/t/p/w500/${_getPopularMovieList?[index].backdropPath}', title:  _getPopularMovieList?[index].title ?? "", voteAverage: "${_getPopularMovieList?[index].voteAverage}", voteCount: "${_getPopularMovieList?[index].voteCount}")
              );
            }),


            ///Actor image slider
            _getActorList== null|| _getActorList.isEmpty?const Center(child: CircularProgressIndicator(color: Colors.red,)):CarouselSliderWidget(autoPlay:false,itemCount: _getActorList?.length ?? 0, itemBuilder: (context,index){
              return Hero(
                tag: 'movie_${_getActorList?[index].id}',
                child: _getActorList == null || _getActorList.isEmpty ? const CircularProgressIndicator(color: Colors.red,):CarouselStackWidget(showCircleAvatar: false,imagerUrl: 'https://image.tmdb.org/t/p/w500/${_getActorList?[index].profilePath}', imageHeight: kPS400px, imageWidth: MediaQuery.of(context).size.width*0.8,
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ActorDetailScreen(actorID: _getActorList?[index].id,)));
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
            }, enableInfiniteScroll: false,),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}


