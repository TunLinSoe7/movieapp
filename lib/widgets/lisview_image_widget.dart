import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_data.dart';
import '../constant/dimens.dart';
class ListViewImage extends StatelessWidget {
  const ListViewImage({Key? key, required this.images, required this.imageHeight, required this.imageWidth, this.onTap}) : super(key: key);
final List<Object> images;
final double imageHeight;
final double imageWidth;
final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: imageHeight,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context,index){

            return Container(
                margin: const EdgeInsets.symmetric(horizontal: kPS15px,vertical: kPS15px),
                child: Stack(
                  children: [

                     ClipRRect(
                       borderRadius: BorderRadius.circular(kPS10px),
                       child: GestureDetector(
                         onTap: onTap,
                         child: CachedNetworkImage(
                           height: imageHeight,
                           width: imageWidth,
                           imageUrl: movieData[index]['image']!,fit: BoxFit.cover,
                           placeholder: (context,url)=>Image.asset("images/place_holder.jpg"),
                           errorWidget: (context,url,error)=>const Center(child: CircularProgressIndicator(),),),
                       ),
                     ) ,

                    Positioned(
                        bottom:1,
                        child: Column(
                          crossAxisAlignment:CrossAxisAlignment.start,
                          children:  [
                            Padding(
                              padding:  const EdgeInsets.only(left: 8.0),
                              child: Wrap(children:  [Text(movieData[index]['name']!,style:const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 17),)]),
                            ),
                            const SizedBox(height: kPS10px,),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Row(
                                children:  [
                                  const Icon(Icons.star_border,color: Colors.yellow,),
                                  Text(movieData[index]['rating']!,style:const  TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                                  const SizedBox(width: kPS50px,),
                                  Text("${movieData[index]['votes']} votes",style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                                ],
                              ),
                            ),
                          ],
                        )),
                    // Container(
                    //   height:imageHeight,
                    //   width: imageHeight,
                    //   decoration: BoxDecoration(
                    //     gradient: LinearGradient(
                    //       begin: Alignment.topCenter,
                    //       end: Alignment.bottomCenter,
                    //       colors: [Colors.transparent, Colors.black.withOpacity(0.8)],
                    //     ),
                    //   ),
                    // ),
                  ],
                )
            );
          }, itemCount: images.length,),
    );
  }
}
