import 'package:hive/hive.dart';
import 'package:movie_app/data/vos/movie_vo/result_vo.dart';
import '../../../constant/hive_constant.dart';
part 'movie_hive_vo.g.dart';
@HiveType(typeId: kMovieHiveTypeID)
class MovieHiveVO{
  @HiveField(0)
  List<MovieVO>? resultVO;
  MovieHiveVO({required this.resultVO});
}