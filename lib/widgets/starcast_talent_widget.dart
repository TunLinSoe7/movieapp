import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../constant/assest_images.dart';
import '../constant/dimens.dart';
class StarCastTalentWidget extends StatelessWidget {
  const StarCastTalentWidget({Key? key, required this.images}) : super(key: key);
final List<Map<String,String>> images;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kPS100px,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: images.length,itemBuilder: (context,index){
        return Column(
          children: [
            SizedBox(
              width: kPS200px,
              child: ListTile(
                leading:ClipOval(
                  child: CachedNetworkImage(
                    width: 50,
                    height: 50,
                    imageUrl: images[index]['image']!,
                    fit: BoxFit.fill,
                    placeholder: (url,error)=> Image.asset(kPlaceHoderImage),),
                ),
                title: Text(images[index]['type']!,style: const TextStyle(color: Colors.white,fontSize: kPS14px,fontWeight: FontWeight.bold),),
                subtitle: Text(images[index]['name']!,style: const TextStyle(color: Colors.white70,fontSize: kPS12px)),
              ),
            ),
          ],
        );
      }),);
  }
}
