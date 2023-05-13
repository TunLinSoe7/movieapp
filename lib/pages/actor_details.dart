import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_data.dart';
import '../constant/dimens.dart';
import '../constant/strings.dart';
import '../widgets/lisview_image_widget.dart';
import '../widgets/sliverappbar_widget.dart';
import '../widgets/table_row_widget.dart';
class ActorDetail extends StatelessWidget {
  const ActorDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SliverAppBarWdiget(
        expandedHeight: kPS300px, title: Wrap(children: const [
        Text("Sharukh khan",style: TextStyle(fontSize: kPS15px,fontWeight: FontWeight.bold),),
      ],),imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSpTqf0dXUHBJKfcSQX3k_Wvs7IhUZlhm8t1A&usqp=CAU",
        body:SingleChildScrollView(
          child: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: kPS10px,right: kPS10px,top: kPS20px),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:[
                const Text(kBiographyText,style: TextStyle(fontWeight: FontWeight.bold,fontSize: kPS16px,color: Colors.white),),
                const Divider(color: Colors.white,thickness: 2,),
                const SizedBox(height: kPS10px,),
                const Text("Shazam is a fictional superhero that first appeared in American comic books published by Fawcett Comics in 1939. The character was created by artist C. C. Beck and writer Bill Parker. Originally named Captain Marvel, the character's name was changed to Shazam due to trademark conflicts with Marvel Comics.",
                  style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white70),textAlign: TextAlign.justify,),
                const SizedBox(height: kPS10px,),
                const Text(kMoreInfoText,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: Colors.white),),
                const Divider(color: Colors.white,thickness: 2,),
                const CustomTable(
                  data: [
                    ['Place Of Birth','Spokane,Washington,USA'],
                    ['BirthDay','1997-09-12'],
                    ['DeadDay','-'],
                    ['Gender','Female'],
                    ['Popularity','166.98'],
                  ],
                ),
                const SizedBox(height: kPS15px,),
                const Text(kKnowForText,style: TextStyle(fontWeight: FontWeight.bold,fontSize: kPS16px,color: Colors.white),),
                ListViewImage(images: actorData,imageHeight: kPS260px,imageWidth: kPS180px,),
              ],),
          ),
        ), centerTitle: true,),
    );
  }
}
