import 'package:movie_app/network/response/moviedetails_response/movie_details_response.dart';

abstract class MovieDetailResponseDAO{

void save(MovieDetailsResponse movieDetail);

MovieDetailsResponse? getMovieDetailResponseFromDataBase(int movieID);

Stream watchBox();

Stream<MovieDetailsResponse?> getMovieDetailResponseFromDataBaseStream(int movieID);
}