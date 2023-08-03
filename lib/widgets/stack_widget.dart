import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/constant/api_constant.dart';
import 'package:movie_app/constant/assest_images.dart';

import '../constant/dimens.dart';


class StackWidget extends StatelessWidget {
  const StackWidget({Key? key, required this.imageUrl, required this.title, required this.voteAverage, required this.voteCount, required this.imageHeight, required this.imageWidth, required this.width}) : super(key: key);
final String imageUrl;
final String title;
final String voteAverage;
final String voteCount;
final double imageHeight;
final double imageWidth;
final double width;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(kPS10px),
          child: GestureDetector(
            child: CachedNetworkImage(
              height: imageHeight,
              width: imageWidth,
              imageUrl: imageUrl,fit: BoxFit.cover,
              placeholder: (context,url)=>Image.asset(kPlaceHoderImage),
              errorWidget: (context,url,error)=> Center(child: Image.network(kErrorImage),),),
          ),
        ) ,
        Positioned(
            bottom:1,
            child: Column(
              crossAxisAlignment:CrossAxisAlignment.start,
              children:  [
                Padding(
                  padding:  const EdgeInsets.only(left: 8.0),
                  child: Wrap(
                    children:[
                      Container(
                        padding: const EdgeInsets.only(left: 3,right: 3),
                          width:imageWidth,
                          child: Text( title,style:const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 17),))

                  ]),
                ),
                const SizedBox(height: kPS10px,),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Row(
                    children:  [
                      Row(
                        mainAxisAlignment:MainAxisAlignment.spaceBetween,
                        children: [
                          const  Icon(Icons.star_border,color: Colors.yellow,),
                          Text(voteAverage,style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                        ],
                      ),
                      SizedBox(width: width,),
                      Text("$voteCount votes",style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                    ],
                  ),
                ),
              ],
            )),
        Container(
          height:imageHeight,
          width: imageWidth,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.transparent, Colors.black.withOpacity(0.8)],
            ),
          ),
        ),
      ],
    );
  }
}
