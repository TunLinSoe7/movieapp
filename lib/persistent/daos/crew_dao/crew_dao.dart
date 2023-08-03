import 'package:movie_app/data/vos/credit_vo/crew_hive_vo.dart';

import '../../../data/vos/credit_vo/crew_vo.dart';

abstract class CrewDAO{
  void save(CrewHiveVO crewHiveVO,int crewID);
  CrewHiveVO? getCrewDataFromDatabase(int crewID);
  Stream<CrewHiveVO?> getCrewDataFromStream(int crewID);
  Stream watchBox();
}