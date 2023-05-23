
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
class CarouselSliderWidget extends StatelessWidget {
  const CarouselSliderWidget({
    Key? key,
    required this.itemCount,
    required this.itemBuilder, required this.autoPlay,
  }) : super(key: key);

  final int? itemCount;
  final IndexedWidgetBuilder itemBuilder;
  final bool autoPlay;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: itemCount,
      itemBuilder: (context, index, realIndex) {
        return itemBuilder(context, index);
      },
      options: CarouselOptions(
        height: 400,
        enableInfiniteScroll: false,
        viewportFraction: 0.8,
        enlargeCenterPage: true,
        autoPlay: autoPlay,
      ) ,
    );
  }
}


