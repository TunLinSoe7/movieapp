import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_data.dart';
import 'package:movie_app/widgets/sliverappbar_widget.dart';
import 'package:movie_app/widgets/starcast_talent_widget.dart';
import '../constant/assest_images.dart';
import '../constant/dimens.dart';
import '../constant/strings.dart';
import '../widgets/lisview_image_widget.dart';

class MovieDetail extends StatelessWidget {
  const MovieDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SliverAppBarWdiget(

        centerTitle: false,
        expandedHeight: kPS300px,
        title: Wrap(
          children: const [
            Text(
              "ShaZam!Fury Of The God",
              style:
                  TextStyle(fontSize: kPS15px, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        imageUrl:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcScH15cLFHuj8ovdVjE6pOT3gOMDv6mepbUOQ&usqp=CAU",
        body: SingleChildScrollView(
          child: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(
                left: kPS10px, right: kPS10px, top: kPS20px),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  kStoryLineText,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: kPS16px,
                      color: Colors.white),
                ),
                const SizedBox(
                  height: kPS10px,
                ),
                const Text(
                  "Shazam is a fictional superhero that first appeared in American comic books published by Fawcett Comics in 1939. The character was created by artist C. C. Beck and writer Bill Parker. Originally named Captain Marvel, the character's name was changed to Shazam due to trademark conflicts with Marvel Comics.",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white70),
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(
                  height: kPS10px,
                ),
                const Text(
                  kStarCastText,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.white),
                ),
                StarCastTalentWidget(images: actorData),
                const Text(
                  kTalentSquadText,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.white),
                ),
                StarCastTalentWidget(images: actorData),
                const Text(
                  kCompanyText,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.white),
                ),
                SizedBox(
                  height: kPS100px,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: const EdgeInsets.all(kPS10px),
                        child: Column(
                          children: [
                            ClipOval(
                              child: CachedNetworkImage(
                                width: 50,
                                height: 50,
                                imageUrl: companyData[index]['image']!,
                                fit: BoxFit.fill,
                                placeholder: (url, error) =>
                                    Image.asset(kPlaceHoderImage),
                              ),
                            ),
                            const SizedBox(
                              height: kPS10px,
                            ),
                            Text(
                              companyData[index]['name']!,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      );
                    },
                    itemCount: companyData.length,
                  ),
                ),
                const Text(
                  kRecommendedText,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: kPS16px,
                      color: Colors.white),
                ),
                ListViewImage(

                  images: actorData,
                  imageHeight: kPS260px,
                  imageWidth: kPS180px,
                ),
              ],
            ),
          ),
        ),
        titlePadding: const EdgeInsets.only(left: kPS15px, bottom: kPS20px),
        child: const Text(
          "Family|Action|Adventure|1h25m",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white70),
        ),
      ),
    );
  }
}
