import 'package:hive/hive.dart';
import 'package:movie_app/constant/hive_constant.dart';

import 'crew_vo.dart';
part 'crew_hive_vo.g.dart';
@HiveType(typeId: kCrewHiveTypeID)
class CrewHiveVO{
  @HiveField(0)
  List<CrewVO>? crewHiveVO;
  CrewHiveVO({required this.crewHiveVO});
}