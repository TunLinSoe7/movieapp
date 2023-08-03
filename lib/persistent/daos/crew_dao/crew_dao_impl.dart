import 'package:hive/hive.dart';
import 'package:movie_app/constant/hive_constant.dart';
import 'package:movie_app/data/vos/credit_vo/crew_hive_vo.dart';
import 'package:movie_app/data/vos/credit_vo/crew_vo.dart';
import 'package:movie_app/persistent/daos/crew_dao/crew_dao.dart';

class CrewDAOImpl extends CrewDAO{
  CrewDAOImpl._();
  static final CrewDAOImpl _singleton = CrewDAOImpl._();
  factory CrewDAOImpl()=>_singleton;
  @override
  CrewHiveVO? getCrewDataFromDatabase(int crewID) =>
_boxCrew().get(crewID);
  @override
  Stream<CrewHiveVO?> getCrewDataFromStream(int crewID) =>
      Stream.value(getCrewDataFromDatabase(crewID));

  @override
  void save(CrewHiveVO crewHiveVO,int crewID) {
    if(crewHiveVO!=null){
      _boxCrew().put(crewID, crewHiveVO);
    }
  }

  @override
  Stream watchBox()=>_boxCrew().watch();
  Box<CrewHiveVO> _boxCrew()=>Hive.box<CrewHiveVO>(kBoxNameForCrew);
}