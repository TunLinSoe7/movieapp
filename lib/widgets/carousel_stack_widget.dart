import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../constant/assest_images.dart';
import '../constant/dimens.dart';
class CarouselStackWidget<T> extends StatelessWidget {
  const CarouselStackWidget({Key? key,  this.showActorName=true,  this.showCircleAvatar=true, required this.imagerUrl,  this.name, required this.imageHeight, required this.imageWidth, this.decoration, this.onTap,}) : super(key: key);
final bool showActorName;
final bool showCircleAvatar;
final String imagerUrl;
final String? name;
final double imageHeight;
final double imageWidth;
final Decoration? decoration;
final void Function()? onTap;


  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        ClipRRect(
            borderRadius: BorderRadius.circular(kPS10px),
            child: Stack(
              children: [
                CachedNetworkImage(
                  imageUrl: imagerUrl,
                  height: imageHeight,
                  width: imageWidth,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Image.asset(kPlaceHoderImage),
                  errorWidget: (context, url, error) =>
                  const Center(child: Text('image not found...',style: TextStyle(color: Colors.white,fontSize: 16),),),
                ),
                GestureDetector(
                  onTap: onTap,
                  child: Container(
                    decoration: decoration,
                  ),
                ),
                if(showActorName)
                Positioned(
                  bottom: 10,
                    child:Container(
                      width: MediaQuery.of(context).size.width*0.8,
                      alignment: Alignment.bottomCenter,
                        child: Wrap(children: [
                      Text(name?? '',style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),)
                    ],))),
              ],
            )),
        if(showCircleAvatar)
          const Positioned.fill(
              child: Center(
                child: CircleAvatar(
                    backgroundColor:Colors.red,
                    child:  Icon(Icons.play_arrow_outlined)),
              )),
      ],
    );
  }
}
