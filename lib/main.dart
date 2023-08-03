import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/bloc/search_page_bloc/search_page_bloc.dart';
import 'package:movie_app/constant/hive_constant.dart';
import 'package:movie_app/data/vos/actor_vo/knowfor_vo/know_for_vo.dart';
import 'package:movie_app/data/vos/actor_vo/result_vo/actor_result_vo.dart';
import 'package:movie_app/data/vos/credit_vo/cast_vo.dart';
import 'package:movie_app/data/vos/credit_vo/crew_hive_vo.dart';
import 'package:movie_app/data/vos/credit_vo/crew_vo.dart';
import 'package:movie_app/data/vos/genres_vo/genres_vo.dart';
import 'package:movie_app/data/vos/movie_vo/movie_hive_vo.dart';
import 'package:movie_app/data/vos/productionCompanies_vo/production_companies_vo.dart';
import 'package:movie_app/data/vos/productionCountries_vo/production_countries_vo.dart';
import 'package:movie_app/data/vos/spokenlanguages_vo/spoken_language_vo.dart';
import 'package:movie_app/network/response/actor_detail_response/actor_detail_response.dart';
import 'package:movie_app/network/response/moviedetails_response/movie_details_response.dart';
import 'package:movie_app/pages/home_page.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'constant/assest_images.dart';
import 'data/vos/credit_vo/cast_hive_vo.dart';
import 'data/vos/movie_vo/result_vo.dart';
void main() async{
  await Hive.initFlutter();
  Hive.registerAdapter(MovieVOAdapter());
  Hive.registerAdapter(GenresVOAdapter());
  Hive.registerAdapter(MovieDetailsResponseAdapter());
  Hive.registerAdapter(ProductionCompaniesVOAdapter());
  Hive.registerAdapter(ProductionCountriesVOAdapter());
  Hive.registerAdapter(SpokenLanguagesVOAdapter());
  Hive.registerAdapter(ActorResultsVOAdapter());
  Hive.registerAdapter(KnownForAdapter());
  Hive.registerAdapter(CastHiveVOAdapter());
  Hive.registerAdapter(CastVOAdapter());
  Hive.registerAdapter(CrewVOAdapter());
  Hive.registerAdapter(CrewHiveVOAdapter());
  Hive.registerAdapter(MovieHiveVOAdapter());
  Hive.registerAdapter(ActorDetailResponseAdapter());
  await Hive.openBox<MovieVO>(kBoxNameForMovieVO);
  await Hive.openBox<GenresVO>(kBoxNameForGenres);
  await Hive.openBox<MovieHiveVO>(kBoxNameForMovieHiveType);
  await Hive.openBox<ProductionCountriesVO>(kBoxNameForProductionCountry);
  await Hive.openBox<SpokenLanguagesVO>(kBoxNameForSpokenLanguage);
  await Hive.openBox<ProductionCompaniesVO>(kBoxNameForProductionCompany);
  await Hive.openBox<MovieDetailsResponse>(kBoxNameForMovieDetail);
  await Hive.openBox<ActorResultsVO>(kBoxNameForActorVO);
  await Hive.openBox<KnownFor>(kBoxNameForKnowFor);
  await Hive.openBox<CastHiveVO>(kBoxNameForCast);
  await Hive.openBox<CrewHiveVO>(kBoxNameForCrew);
  await Hive.openBox<ActorDetailResponse>(kBoxNameForActorDetail);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=>SearchPageBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: AnimatedSplashScreen(
            duration: 1000,
              splash: SizedBox(
                height: 180,
                width: 180,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child:Image.asset(kPlaceHoderImage,fit: BoxFit.fill),
                ),
              ),
              nextScreen:const HomePage(),
              splashTransition: SplashTransition.fadeTransition,
              backgroundColor: Colors.white
              ),
        ),
      ),
    );
  }
}
