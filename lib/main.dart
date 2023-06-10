import 'package:flutter/material.dart';
import 'package:movie_app/constant/hive_constant.dart';
import 'package:movie_app/data/vos/actor_vo/knowfor_vo/know_for_vo.dart';
import 'package:movie_app/data/vos/actor_vo/result_vo/actor_result_vo.dart';
import 'package:movie_app/data/vos/genres_vo/genres_vo.dart';
import 'package:movie_app/data/vos/productionCompanies_vo/production_companies_vo.dart';
import 'package:movie_app/data/vos/productionCountries_vo/production_countries_vo.dart';
import 'package:movie_app/data/vos/spokenlanguages_vo/spoken_language_vo.dart';
import 'package:movie_app/network/response/moviedetails_response/movie_details_response.dart';
import 'package:movie_app/pages/home_page.dart';
import 'package:hive_flutter/hive_flutter.dart';

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
  await Hive.openBox<MovieVO>(kBoxNameForMovieVO);
  await Hive.openBox<GenresVO>(kBoxNameForGenres);
  await Hive.openBox<ProductionCountriesVO>(kBoxNameForProductionCountry);
  await Hive.openBox<SpokenLanguagesVO>(kBoxNameForSpokenLanguage);
  await Hive.openBox<ProductionCompaniesVO>(kBoxNameForProductionCompany);
  await Hive.openBox<MovieDetailsResponse>(kBoxNameForMovieDetail);
  await Hive.openBox<ActorResultsVO>(kBoxNameForActorVO);
  await Hive.openBox<KnownFor>(kBoxNameForKnowFor);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: HomePage(),
      ),
    );
  }
}
