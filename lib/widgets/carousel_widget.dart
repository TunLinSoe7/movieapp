import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
class CarouselImage<T> extends StatelessWidget {
  const CarouselImage({
    Key? key,
    required this.future,
    required this.itemBuilder, this.dataLimit,
  }) : super(key: key);
  final Future<List<T>?> future;
  final Widget Function(BuildContext context, T items) itemBuilder;
  final int? dataLimit;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<T>?>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.red),
          );
        } else if (snapshot.hasError) {
          return Center(child: Image.asset("images/images.png"));
        } else {
           List<T>? movieData = snapshot.data;
          if ( movieData== null || movieData.isEmpty) {
            return const Center(
              child: Text("No data available"),
            );
          }
          return SizedBox(
            height: 400,
            child: CarouselSlider.builder(
              itemCount:movieData.length > (dataLimit ?? movieData.length) ? (dataLimit ?? movieData.length) : movieData.length,
              itemBuilder: (context, index,realIndex) => itemBuilder(context, movieData[index]), options:CarouselOptions(
              height: 400,
              enableInfiniteScroll: false,
              viewportFraction: 0.8,
              enlargeCenterPage: true,
              autoPlay: false,
            ) ,
            ),
          );
        }
      },
    );
  }
}