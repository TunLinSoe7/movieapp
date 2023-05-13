import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_data.dart';
import 'package:movie_app/pages/actor_details.dart';
import 'package:movie_app/pages/movie_details.dart';
import 'package:movie_app/widgets/lisview_image_widget.dart';
import 'package:movie_app/widgets/carousel_widget.dart';
import '../constant/dimens.dart';
import '../constant/strings.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: kPS80px,
            ),
            /// Search Bar
            Row(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: kPS10px),
                  margin: const EdgeInsets.only(left: kPS10px, right: kPS10px),
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(kPS10px)),
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: kPS50px,
                  child: const Text(
                    kSearchBarText,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const Spacer(),
                Container(
                  margin: const EdgeInsets.only(right: kPS10px),
                  decoration: BoxDecoration(
                      color: Colors.redAccent.shade100,
                      borderRadius: BorderRadius.circular(kPS10px)),
                  width: kPS40px,
                  height: kPS40px,
                  child: const Icon(
                    Icons.search_rounded,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: kPS20px,
            ),
            /// Categories
            SizedBox(
              width: double.infinity,
              height: kPS40px,
              child: ListView.separated(
                  separatorBuilder: (context, index) => const SizedBox(
                        width: kPS10px,
                      ),
                  scrollDirection: Axis.horizontal,
                  itemCount: categoryTitles.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(kPS8px),
                        margin: const EdgeInsets.symmetric(horizontal: kPS10px),
                        decoration: BoxDecoration(
                            color:
                                selectedIndex == index ? Colors.redAccent : null,
                            borderRadius: BorderRadius.circular(5)),
                        child: Text(
                          categoryTitles[index],
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ),
                    );
                  }),
            ),
            const SizedBox(
              height: kPS15px,
            ),
            /// BannerImage

            SliderWidget(
                listData: movieData, imageHeight: kPS400px,decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withOpacity(0.8)]),
            ),backgroundColor: Colors.red,
            showActorName: false,),
            const SizedBox(height: kPS20px,),
            ListViewImage(

              images: movieData,imageHeight: kPS200px,imageWidth: kPS180px,onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>  MovieDetail() ));
            },
            ),
            ///You May Like images
            Container(
              margin: const EdgeInsets.all(kPS15px),
              alignment: Alignment.centerLeft,
                child: const Text(kYouMayLikeText,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.white),)),
            ListViewImage(

              images: movieData
              ,imageHeight: kPS260px,imageWidth: kPS180px,),
            ///Popular
            Container(
              margin: const EdgeInsets.all(kPS15px),
              alignment: Alignment.centerLeft,
                child: const Text(kPopularText,style: TextStyle(fontWeight: FontWeight.bold,fontSize: kPS18px,color: Colors.white),)),
            ListViewImage(

                images: movieData ,imageHeight: kPS260px,imageWidth: kPS180px),
            const SizedBox(height: kPS10px,),
            ///Actor image slider
            SliderWidget(listData: actorData, imageHeight: kPS350px,decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withOpacity(0.3)]),
            ),backgroundColor: Colors.red,showCircleAvatar: false,showActorName: true,onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const ActorDetail()));
            },),
            const SizedBox(height: 30,),
          ],
        ),
      ),
    );
  }
}

List<String> categoryTitles = [
  'Adventure',
  'Horror',
  'Anime',
  'Cartoon',
  'Drama',
  'Actions',
];

