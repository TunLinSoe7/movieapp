import '../../../data/vos/credit_vo/cast_hive_vo.dart';

abstract class CastDAO{
  void save(CastHiveVO castHiveVO,int castID);
  CastHiveVO? getCastDataFromDatabase(int castID);
  Stream<CastHiveVO?> getCastDataFromStream(int castID);
  Stream watchBox();
}
