import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_data.dart';

import '../constant/assest_images.dart';
import '../constant/dimens.dart';
class SliderWidget extends StatelessWidget {
  const SliderWidget({Key? key, required this.imageHeight, this.decoration,  required this.backgroundColor, this.showCircleAvatar = true, required this.listData,  this.showActorName=true, this.onTap }) : super(key: key);
final List<Map<String,dynamic>> listData;
final double imageHeight ;
final Decoration? decoration;
final Color backgroundColor;
final bool showCircleAvatar;
final bool showActorName;
final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return  CarouselSlider.builder(
      itemCount: listData.length,
      itemBuilder: (BuildContext context, int index, int realIndex) {
        return Stack(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(kPS10px),
                child: Stack(
                  children: [
                    CachedNetworkImage(
                      imageUrl: listData[index]['image'],
                      height: imageHeight,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Image.asset(kPlaceHoderImage),
                      errorWidget: (context, url, error) =>
                          const Center(child: CircularProgressIndicator(color: Colors.red,),),
                    ),
                    GestureDetector(
                      onTap: onTap,
                      child: Container(
                        decoration:  decoration,
                      ),
                    ),
                    if(showActorName)
                    Positioned(
                      bottom: 10,
                        left: 100,
                        child:Text(actorData[index]['name']!,style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),)),
                  ],
                )),
           if(showCircleAvatar)
             Positioned.fill(
                 child: Center(
                   child: CircleAvatar(
                       backgroundColor: backgroundColor,
                       child: const Icon(Icons.play_arrow_outlined)),
                 )),
          ],
        );
      },
      options: CarouselOptions(
        height: imageHeight,
        viewportFraction: 0.8,
        initialPage: 0,
        enableInfiniteScroll: false,
        reverse: false,
        autoPlay: false,
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
        enlargeFactor: 0.3,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
