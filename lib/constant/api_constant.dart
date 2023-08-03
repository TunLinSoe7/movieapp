

///MOVIE BASE URL
const kMovieBaseURL = 'https://api.themoviedb.org/3';

///End Point
const kGetNowPlayingMoviesEndPoint = '/movie/now_playing';
const kGetTopRatedEndPoint = '/movie/top_rated';

const kGenresEndPoint = '/genre/movie/list';
const kPopularMoviesEndPoint = '/movie/popular';
const kGetActorEndPoint = '/person/popular';
const kGetMovieDetailsEndPoint = '/movie/{$kPathParameterMovieID}';
const kGetActorDetailEndPoint = '/person/{$kPathParameterMovieID}';
const kGetSimilarMoviesEndPoint = '/movie/{$kPathParameterMovieID}/similar';
const kGetCatAndCrewEndPoint = '/movie/{$kPathParameterMovieID}/credits';
const kGetSearchBarEndPoint = '/search/movie';
const kGetMovieByGenreEndPoint = '/discover/movie';
///API KEY
const kApiKey = '6ba57a8fa213613268b61de49d70fffe';
const kQueryKey ='zombie';
const kQueryPage = 'page';
///Query Params
const kQueryParamsApiKey = 'api_key';
const kQueryParams ='query';
const kQueryGenreID = 'with_genres';

///Path Parameter
const kPathParameterMovieID = 'movie_id';
///Prefix ImageLink
const String kPrefixImage = 'https://image.tmdb.org/t/p/w500/';
const String kErrorImage ="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRNZo8HJXlzsEbcnfi6ciTTC9I1SF8Pb0wY6A&usqp=CAU";
const String kNullImage ="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQtYqXjw6IR_opev4UADLjT8TPcLmWYQsx_YQ&usqp=CAU";
