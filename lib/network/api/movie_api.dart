import 'package:movie_app/constant/api_constant.dart';
import 'package:movie_app/network/response/actor_detail_response/actor_detail_response.dart';
import 'package:movie_app/network/response/moviedetails_response/movie_details_response.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import '../response/actor_response/actor_response.dart';
import '../response/genres_response/genres_response.dart';
import '../response/movie_response/movie_response.dart';
part 'movie_api.g.dart';
@RestApi(baseUrl: kMovieBaseURL)
abstract class MovieApi{
 factory MovieApi(Dio dio) = _MovieApi;

 @GET(kGenresEndPoint)
 Future<GenresResponse> getGenresResponse(@Query(kQueryParamsApiKey) String apiKey,);

 @GET(kGetNowPlayingMoviesEndPoint)
 Future<MovieResponse> getNowPlayingMovieResponse(
     @Query(kQueryParamsApiKey) String apiKey,
     );

 @GET(kGetTopRatedEndPoint)
 Future<MovieResponse> getTopRatedResponse(
     @Query(kQueryParamsApiKey) String apiKey,);

  @GET(kPopularMoviesEndPoint)
 Future<MovieResponse> getPopularMoviesResponse(
     @Query(kQueryParamsApiKey) String apiKey,);

  @GET(kGetActorEndPoint)
 Future<ActorResponse> getActorResponse(
     @Query(kQueryParamsApiKey) String apiKey,);

  @GET(kGetActorDetailEndPoint)
 Future<ActorDetailResponse> getActorDetailResponse(
     @Query(kQueryParamsApiKey) String apiKey,
     @Path(kPathParameterMovieID) int movieID
      );
 @GET(kGetMovieDetailsEndPoint)
 Future<MovieDetailsResponse> getMovieDetailsResponse(
     @Query(kQueryParamsApiKey) String apiKey,
     @Path(kPathParameterMovieID) int movieID);
}
