import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/constant/api_constant.dart';
import 'package:movie_app/data/vos/credit_vo/cast_vo.dart';
import '../constant/assest_images.dart';
import '../constant/dimens.dart';
class StarCastTalentWidget<T> extends StatelessWidget {
  const StarCastTalentWidget({Key? key, required this.itemCount, required this.itemBuilder}) : super(key: key);
  final int? itemCount;
  final Widget?Function(BuildContext,int) itemBuilder;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kPS100px,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
            itemCount:itemCount ,
        itemBuilder: itemBuilder,
         ),);
  }}
