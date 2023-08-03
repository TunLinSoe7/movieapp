import 'package:hive/hive.dart';
import 'package:movie_app/constant/hive_constant.dart';

import 'cast_vo.dart';
part'cast_hive_vo.g.dart';
@HiveType(typeId: kCastHiveTypeID)
class CastHiveVO{
  @HiveField(0)
  final List<CastVO> hiveCast;
   CastHiveVO(this.hiveCast);
}