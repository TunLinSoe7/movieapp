import 'package:hive/hive.dart';
import 'package:movie_app/constant/hive_constant.dart';
import 'package:movie_app/data/vos/genres_vo/genres_vo.dart';
import 'package:movie_app/persistent/daos/genres_dao/genres_dao.dart';

class GenresDAOImpl extends GenresDAO{
  GenresDAOImpl._();
  static final GenresDAOImpl _singleton = GenresDAOImpl._();
  factory GenresDAOImpl()=>_singleton;
  @override
  List<GenresVO> getGenresListFromDataBase() =>_genresBox().values.toList();

  @override
  Stream<List<GenresVO>?> getGenresListFromDataBaseStream() =>
      Stream.value(getGenresListFromDataBase());
  @override
  void save(List<GenresVO> genresList) {
    for(GenresVO genresVO in genresList){
      _genresBox().put(genresVO.id, genresVO);
    }
  }

  @override

   Box<GenresVO> _genresBox() => Hive.box<GenresVO>(kBoxNameForGenres);

  @override
  Stream watchBox()=>_genresBox().watch();


}