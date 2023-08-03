import 'package:flutter/material.dart';
import 'package:movie_app/bloc/home_page_bloc/home_page_bloc.dart';
import 'package:movie_app/constant/api_constant.dart';
import 'package:movie_app/data/vos/actor_vo/result_vo/actor_result_vo.dart';
import 'package:movie_app/extensions/extension.dart';
import 'package:movie_app/pages/actor_details.dart';
import 'package:movie_app/pages/movie_details.dart';
import 'package:movie_app/pages/search_screen.dart';
import 'package:movie_app/widgets/carousel_stack_widget.dart';
import 'package:movie_app/widgets/carousel_widget.dart';
import 'package:movie_app/widgets/lisview_image_widget.dart';
import 'package:movie_app/widgets/stack_widget.dart';
import 'package:provider/provider.dart';
import '../bloc/view_items/view_item.dart';
import '../constant/dimens.dart';
import '../constant/strings.dart';
import '../data/vos/genres_vo/genres_vo.dart';
import '../data/vos/movie_vo/result_vo.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomePageBloc>(
      create: (BuildContext context) => HomePageBloc(),
      child: Scaffold(
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
                    margin:
                        const EdgeInsets.only(left: kPS10px, right: kPS10px),
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(kPS10px)),
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: kPS50px,
                    child: TextField(
                      onTap: () {
                        context.navigateToOtherScreen(const SearchPage());
                      },
                      cursorColor: Colors.white70,
                      decoration: const InputDecoration(
                        hintText: kSearchBarText,
                        hintStyle: TextStyle(color: Colors.white70),
                        border: InputBorder.none,
                      ),
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

              /// Categories?
              Selector<HomePageBloc, List<GenresVO>>(
                selector: (_, bloc) => bloc.genreList,
                builder: (_, genreList, child) {
                  return SizedBox(
                    width: double.infinity,
                    height: kPS40px,
                    child: genreList.isEmpty
                        ? const Center(
                            child: CircularProgressIndicator(
                            color: Colors.red,
                          ))
                        : Selector<HomePageBloc, int>(
                            selector: (_, bloc) => bloc.selectedIndex,
                            builder: (_, indexData, __) {
                              return ListView.separated(
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(
                                        width: kPS10px,
                                      ),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: genreList.length,
                                  itemBuilder: (context, index) {
                                    return GenreItemView(
                                        genreList: genreList[index],
                                        index: index,
                                        indexData: indexData);
                                  });
                            },
                          ),
                  );
                },
              ),
              const SizedBox(
                height: kPS20px,
              ),

              /// GetNowPlayingMovies
              Selector<HomePageBloc,List<MovieVO>>(
                selector: (_,bloc)=>bloc.movieData,
                builder: (_,movieData,__){
                  return Selector<HomePageBloc, List<MovieVO>>(
                      selector: (_, bloc) => bloc.bannerMovieData,
                      builder: (_, getNowPlayingData, child) {
                        return Column(
                          children: [
                            getNowPlayingData.isEmpty || getNowPlayingData == null
                                ? const CircularProgressIndicator(
                              color: Colors.red,
                            )
                                : CarouselSliderWidget(
                              autoPlay: false,
                              itemCount: getNowPlayingData.length,
                              itemBuilder: (context, index) {
                                return Hero(
                                  tag: 'movie_${getNowPlayingData[index].id}',
                                  child: CarouselStackWidget(
                                    imagerUrl:
                                    '$kPrefixImage${getNowPlayingData[index].posterPath}',
                                    imageHeight: kPS400px,
                                    imageWidth:
                                    MediaQuery.of(context).size.width *
                                        0.8,
                                    onTap: () {
                                      context.navigateToOtherScreen(
                                          MovieDetailScreen(
                                            movieID: getNowPlayingData[index].id,
                                          ));
                                    },
                                    decoration: const BoxDecoration(
                                        gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                              Colors.transparent,
                                              Colors.black
                                            ])),
                                  ),
                                );
                              },
                              enableInfiniteScroll: true,
                            ),

                            movieData.isEmpty
                                ? const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.red,
                                ))
                                : ListViewImageWidget(
                                listViewHeight: kPS200px,
                                itemCount:movieData.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      context.navigateToOtherScreen(
                                          MovieDetailScreen(
                                            movieID:
                                            movieData[index].id,
                                          ));
                                    },
                                    child: Container(
                                        width: kPS260px,
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: kPS15px,
                                            vertical: kPS15px),
                                        child: StackWidget(
                                            width: kPS100px,
                                            imageWidth: kPS260px,
                                            imageHeight: kPS200px,
                                            imageUrl:
                                            '$kPrefixImage${movieData[index].backdropPath}',
                                            title:
                                            movieData[index].title ??
                                                "",
                                            voteAverage:
                                            "${movieData[index].voteAverage}",
                                            voteCount:
                                            "${movieData[index].voteCount}")),
                                  );
                                }),
                          ],
                        );
                      });
                },
              ),

              ///You May Like images
              Container(
                  margin: const EdgeInsets.all(kPS15px),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    kYouMayLikeText,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: kPS18px,
                        color: Colors.white),
                  )),
              Selector<HomePageBloc, ScrollController>(
                selector: (_, bloc) => bloc.getControllerForTopRated,
                builder: (_, topController, __) {
                  return Selector<HomePageBloc, List<MovieVO>>(
                    selector: (_, bloc) => bloc.getTopRatedData,
                    builder: (_, getTopRatedData, child) {
                      return getTopRatedData.isEmpty
                          ? const Center(
                              child: CircularProgressIndicator(
                              color: Colors.red,
                            ))
                          : ListViewImageWidget(
                              controller: topController,
                              listViewHeight: kPS260px,
                              itemCount: getTopRatedData.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: (){
                                    context.navigateToOtherScreen(
                                        MovieDetailScreen(
                                          movieID: getTopRatedData[index].id,
                                        ));
                                  },
                                  child: Container(
                                      width: kPS180px,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: kPS15px, vertical: kPS15px),
                                      child: StackWidget(
                                          width: kPS50px,
                                          imageWidth: kPS180px,
                                          imageHeight: kPS260px,
                                          imageUrl:
                                              '$kPrefixImage${getTopRatedData[index].backdropPath}',
                                          title:
                                              getTopRatedData[index].title ?? "",
                                          voteAverage:
                                              "${getTopRatedData[index].voteAverage}",
                                          voteCount:
                                              "${getTopRatedData[index].voteCount}")),
                                );
                              });
                    },
                  );
                },
              ),

              ///Popular
              Container(
                  margin: const EdgeInsets.all(kPS15px),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    kPopularText,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: kPS18px,
                        color: Colors.white),
                  )),

              const SizedBox(
                height: kPS10px,
              ),
              Selector<HomePageBloc, List<MovieVO>?>(
                selector: (_, bloc) => bloc.getPopularMovieData,
                builder: (_, popularMovieData, __) {
                  return Selector<HomePageBloc, ScrollController>(
                    selector: (_, bloc) => bloc.getController,
                    builder: (_, controller, child) {
                      return popularMovieData?.isEmpty ?? true
                          ? const Center(
                              child: CircularProgressIndicator(
                              color: Colors.red,
                            ))
                          : ListViewImageWidget(
                              controller: controller,
                              listViewHeight: kPS260px,
                              itemCount: popularMovieData?.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    context.navigateToOtherScreen(
                                        MovieDetailScreen(
                                          movieID:
                                          popularMovieData?[index].id,
                                        ));
                                  },
                                  child: Container(
                                      width: kPS180px,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: kPS15px, vertical: kPS15px),
                                      child: StackWidget(
                                          width: kPS50px,
                                          imageWidth: kPS180px,
                                          imageHeight: kPS260px,
                                          imageUrl:
                                              '$kPrefixImage${popularMovieData?[index].posterPath}',
                                          title: popularMovieData?[index].title ??
                                              "",
                                          voteAverage:
                                              "${popularMovieData?[index].voteAverage}",
                                          voteCount:
                                              "${popularMovieData?[index].voteCount}")),
                                );
                              });
                    },
                  );
                },
              ),

              ///Actor image slider
              Selector<HomePageBloc, List<ActorResultsVO>>(
                selector: (_, bloc) => bloc.getActorData,
                builder: (_, getActorData, child) {
                  return getActorData.isEmpty
                      ? const Center(
                          child: CircularProgressIndicator(
                          color: Colors.red,
                        ))
                      : CarouselSliderWidget(
                          autoPlay: false,
                          itemCount: getActorData.length,
                          itemBuilder: (context, index) {
                            return Hero(
                              tag: 'movie_${getActorData[index].id}',
                              child: getActorData.isEmpty
                                  ? const CircularProgressIndicator(
                                      color: Colors.red,
                                    )
                                  : CarouselStackWidget(
                                      showCircleAvatar: false,
                                      imagerUrl:
                                          '$kPrefixImage/${getActorData[index].profilePath}',
                                      imageHeight: kPS400px,
                                      imageWidth:
                                          MediaQuery.of(context).size.width *
                                              0.8,
                                      onTap: () {
                                        context.navigateToOtherScreen(
                                            ActorDetailScreen(
                                          actorID: getActorData[index].id,
                                          knowFor: getActorData[index].knownFor,
                                        ));
                                      },
                                      decoration: const BoxDecoration(
                                          gradient: LinearGradient(
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              colors: [
                                            Colors.transparent,
                                            Colors.black
                                          ])),
                                    ),
                            );
                          },
                          enableInfiniteScroll: false,
                        );
                },
              ),

              const SizedBox(
                height: kPS30px,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
