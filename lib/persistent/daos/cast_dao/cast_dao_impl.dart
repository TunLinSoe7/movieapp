import 'package:hive/hive.dart';
import 'package:movie_app/constant/hive_constant.dart';
import 'package:movie_app/data/vos/credit_vo/cast_hive_vo.dart';
import 'package:movie_app/persistent/daos/cast_dao/cast_dao.dart';

class CastDAOImpl extends CastDAO{
  CastDAOImpl._();
  static final CastDAOImpl _singleton = CastDAOImpl._();
  factory CastDAOImpl()=>_singleton;

  @override
  CastHiveVO? getCastDataFromDatabase(int castID) =>_boxCast().get(castID);


  @override
  void save(CastHiveVO castHiveVO,int castID) {
    _boxCast().put(castID,castHiveVO);

  }

  @override
  Stream watchBox() =>_boxCast().watch();
Box<CastHiveVO> _boxCast()=>Hive.box<CastHiveVO>(kBoxNameForCast);

  @override
  Stream<CastHiveVO?> getCastDataFromStream(int castID) =>Stream.value(getCastDataFromDatabase(castID));

}