import '../../../data/vos/genres_vo/genres_vo.dart';

abstract class GenresDAO{
  void save(List<GenresVO> genresList);
  List<GenresVO> getGenresListFromDataBase();
  Stream watchBox();
  Stream<List<GenresVO>?> getGenresListFromDataBaseStream();
}