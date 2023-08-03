import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/bloc/movie_detail_bloc/movie_detail_bloc.dart';
import 'package:movie_app/constant/api_constant.dart';
import 'package:movie_app/constant/dimens.dart';
import 'package:movie_app/data/models/movie_model.dart';
import 'package:movie_app/data/models/movie_model_imp.dart';
import 'package:movie_app/data/vos/credit_vo/cast_vo.dart';
import 'package:movie_app/data/vos/credit_vo/crew_hive_vo.dart';
import 'package:movie_app/data/vos/movie_vo/movie_hive_vo.dart';
import 'package:movie_app/data/vos/movie_vo/result_vo.dart';
import 'package:movie_app/data/vos/productionCompanies_vo/production_companies_vo.dart';
import 'package:movie_app/extensions/extension.dart';
import 'package:movie_app/network/response/moviedetails_response/movie_details_response.dart';
import 'package:movie_app/widgets/lisview_image_widget.dart';
import 'package:movie_app/widgets/sliverappbar_widget.dart';
import 'package:provider/provider.dart';
import '../constant/assest_images.dart';
import '../constant/strings.dart';
import '../data/vos/credit_vo/cast_hive_vo.dart';
import '../data/vos/credit_vo/crew_vo.dart';
import '../widgets/stack_widget.dart';
import '../widgets/starcast_talent_widget.dart';

class MovieDetailScreen extends StatelessWidget {
  const MovieDetailScreen({Key? key, this.movieID}) : super(key: key);
  final int? movieID;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => MovieDetailBloc(movieID!),
      child: Scaffold(
          backgroundColor: Colors.black,
          body: Selector<MovieDetailBloc, MovieDetailsResponse?>(
            selector: (_, bloc) => bloc.movieDetailData,
            builder: (_, movieDetailData, child) {
              return movieDetailData == null
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Colors.red,
                      ),
                    )
                  : SliverAppBarWidget(
                      title: Text("${movieDetailData?.title}"),
                      expandedHeight: kPS400px,
                      centerTitle: true,
                      imageUrl: "$kPrefixImage${movieDetailData?.posterPath}",
                      body: SingleChildScrollView(
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
                                "${movieDetailData.overview}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white70),
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
                              Selector<MovieDetailBloc, CastHiveVO?>(
                                selector: (_, bloc) => bloc.castHiveVO,
                                builder: (_, castData, __) {
                                  return StarCastTalentWidget(
                                      itemCount: castData?.hiveCast.length,
                                      itemBuilder: (context, index) {
                                        return Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              width: kPS150px,
                                              child: ListTile(
                                                leading: ClipOval(
                                                  child: CachedNetworkImage(
                                                    width: kPS50px,
                                                    height: kPS50px,
                                                    imageUrl: castData != null
                                                        ? "$kPrefixImage${castData.hiveCast[index].profilePath}"
                                                        : kNullImage,
                                                    fit: BoxFit.fill,
                                                    placeholder: (url, error) =>
                                                        Image.asset(
                                                            kPlaceHoderImage),
                                                  ),
                                                ),
                                                title: Wrap(children: [
                                                  Text(
                                                    "${castData?.hiveCast[index].gender==1?"Female":"Male"} ",
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: kPS14px,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )
                                                ]),
                                                subtitle: Text(
                                                    "${castData?.hiveCast[index].name}",
                                                    style: const TextStyle(
                                                        color: Colors.white70,
                                                        fontSize: kPS12px)),
                                              ),
                                            ),
                                          ],
                                        );
                                      });
                                },
                              ),

                              const Text(
                                kTalentSquadText,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: kPS16px,
                                    color: Colors.white),
                              ),
                              Selector<MovieDetailBloc, CrewHiveVO?>(
                                  selector: (_, bloc) => bloc.crewHiveData,
                                  builder: (_, crewData, __) {
                                    return StarCastTalentWidget(
                                        itemCount: crewData?.crewHiveVO?.length,
                                        itemBuilder: (context, index) {
                                          return Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                width: kPS150px,
                                                child: ListTile(
                                                  leading: ClipOval(
                                                    child: CachedNetworkImage(
                                                      width: kPS50px,
                                                      height: kPS50px,
                                                      imageUrl: crewData?.crewHiveVO?[index]
                                                                  .profilePath !=
                                                              null
                                                          ? "$kPrefixImage${crewData?.crewHiveVO?[index].profilePath}"
                                                          : kNullImage,
                                                      fit: BoxFit.fill,
                                                      placeholder: (url,
                                                              error) =>
                                                          Image.asset(
                                                              kPlaceHoderImage),
                                                    ),
                                                  ),
                                                  title: Wrap(children: [
                                                    Text(
                                                      crewData?.crewHiveVO?[index].gender==1?"Actress":"Actor",
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: kPS14px,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )
                                                  ]),
                                                  subtitle: Text(
                                                      "${crewData?.crewHiveVO?[index].name}",
                                                      style: const TextStyle(
                                                          color: Colors.white70,
                                                          fontSize: kPS12px)),
                                                ),
                                              ),
                                            ],
                                          );
                                        });
                                  }),

                              const Text(
                                kCompanyText,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: kPS16px,
                                    color: Colors.white),
                              ),

                              ///ProductionCompanies
                              Selector<MovieDetailBloc,MovieDetailsResponse?>(selector: (_,bloc)=>bloc.movieData,builder: (_,product,__){
                                return SizedBox(
                                  height: kPS150px,
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: product?.productionCompanies?.length,itemBuilder: (context,index){
                                    return Container(
                                      alignment: Alignment.center,
                                      width: kPS70px,
                                      margin: const EdgeInsets.all(kPS10px),
                                      child: Column(
                                        children: [
                                          CircleAvatar(
                                            backgroundColor:Colors.white,
                                            child: ClipRRect(
                                              borderRadius:BorderRadius.circular(kPS20px),
                                              child: CachedNetworkImage(
                                                width: kPS50px,
                                                height: kPS50px,
                                                imageUrl: "$kPrefixImage${product?.productionCompanies?[index].logoPath}",
                                                placeholder: (context,url)=> Image.asset(kPlaceHoderImage),
                                                errorWidget: (context,url,error)=>Image.network(kErrorImage),),
                                            ),
                                          ),
                                          const SizedBox(height: kPS10px,),
                                          Expanded(child:
                                          Text("${product?.productionCompanies?[index].name}",style: const TextStyle(color: Colors.white),textAlign:TextAlign.center,),
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                                );
                              },),
                              const Text(
                                kRecommendedText,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: kPS16px,
                                    color: Colors.white),
                              ),

                              ///Recommended Movies
                              Selector<MovieDetailBloc, MovieHiveVO?>(
                                selector: (_, bloc) => bloc.similarMovieData,
                                builder: (_, similarMovieData, child) {
                                  return similarMovieData?.resultVO?.isEmpty ?? true
                                      ? const CircularProgressIndicator(
                                          color: Colors.red,
                                        )
                                      : ListViewImageWidget(
                                          listViewHeight: kPS200px,
                                          itemCount: similarMovieData?.resultVO?.length,
                                          itemBuilder: (_, index) {
                                            return InkWell(
                                              onTap: (){
                                                context.navigateToOtherScreen(MovieDetailScreen(movieID: similarMovieData?.resultVO?[index].id,));
                                              },
                                              child: Container(
                                                  width: kPS180px,
                                                  margin:
                                                      const EdgeInsets.symmetric(
                                                          horizontal: kPS15px,
                                                          vertical: kPS15px),
                                                  child: StackWidget(
                                                      width: kPS50px,
                                                      imageWidth: kPS180px,
                                                      imageHeight: kPS260px,
                                                      imageUrl:
                                                          '$kPrefixImage${similarMovieData?.resultVO?[index].posterPath}',
                                                      title: similarMovieData?.resultVO?[
                                                                  index]
                                                          .title ??
                                                          "",
                                                      voteAverage:
                                                          "${similarMovieData?.resultVO?[index].voteAverage}",
                                                      voteCount:
                                                          "${similarMovieData?.resultVO?[index].voteCount}")),
                                            );
                                          });
                                },
                              ),
                            ],
                          ),),));},
          )),
    );
  }
}
