import 'package:flutter/material.dart';
import 'package:movie_app/bloc/actor_detail_bloc/actor_detail_bloc.dart';
import 'package:movie_app/data/vos/actor_vo/knowfor_vo/know_for_vo.dart';
import 'package:movie_app/extensions/extension.dart';
import 'package:movie_app/network/response/actor_detail_response/actor_detail_response.dart';
import 'package:movie_app/pages/movie_details.dart';
import 'package:provider/provider.dart';
import '../constant/api_constant.dart';
import '../constant/dimens.dart';
import '../constant/strings.dart';
import '../data/models/movie_model.dart';
import '../data/models/movie_model_imp.dart';
import '../widgets/lisview_image_widget.dart';
import '../widgets/sliverappbar_widget.dart';
import '../widgets/stack_widget.dart';
import '../widgets/table_row_widget.dart';

class ActorDetailScreen extends StatefulWidget {
  const ActorDetailScreen({Key? key, required this.actorID, this.knowFor})
      : super(key: key);
  final List<KnownFor>? knowFor;
  final int? actorID;

  @override
  State<ActorDetailScreen> createState() => _ActorDetailScreenState();
}

class _ActorDetailScreenState extends State<ActorDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ActorDetailBloc(widget.actorID!),
      child: Selector<ActorDetailBloc, ActorDetailResponse?>(
        selector: (_, bloc) => bloc.actorDetailResponse,
        builder: (_, actorDetailData, __) {
          return Scaffold(
              backgroundColor: Colors.black,
              body: actorDetailData == null
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Colors.red,
                      ),
                    )
                  : SliverAppBarWidget(
                      expandedHeight: kPS400px,
                      centerTitle: true,
                      title: Text("${actorDetailData.name}",style: const TextStyle(fontSize: kPS15px,fontWeight: FontWeight.bold),),
                      imageUrl: "$kPrefixImage${actorDetailData.profilePath}",
                      body: SingleChildScrollView(
                        child: Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(
                              left: kPS10px, right: kPS10px, top: kPS20px),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                kBiographyText,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: kPS16px,
                                    color: Colors.white),
                              ),
                              const Divider(
                                color: Colors.white,
                                thickness: 2,
                              ),
                              const SizedBox(
                                height: kPS10px,
                              ),
                              Text(
                                actorDetailData?.biography ?? '',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white70),
                                textAlign: TextAlign.justify,
                              ),
                              const SizedBox(
                                height: kPS10px,
                              ),
                              const Text(
                                kMoreInfoText,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.white),
                              ),
                              const Divider(
                                color: Colors.white,
                                thickness: 2,
                              ),
                              CustomTable(
                                data: [
                                  [
                                    'Place Of Birth',
                                    '${actorDetailData.placeOfBirth}'
                                  ],
                                  ['BirthDay', '${actorDetailData.birthday}'],
                                  ['DeadDay', '${actorDetailData.deathDay}'],
                                  [
                                    'Gender',
                                    (actorDetailData.gender == 1
                                        ? 'female'
                                        : 'male')
                                  ],
                                  [
                                    'Popularity',
                                    '${actorDetailData.popularity}'
                                  ],
                                ],
                              ),
                              const SizedBox(
                                height: kPS15px,
                              ),

                              /// KnowFor
                              const Text(
                                kKnowForText,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: kPS16px,
                                    color: Colors.white),
                              ),
                              ListViewImageWidget(
                                  listViewHeight: kPS260px,
                                  itemCount: widget.knowFor?.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: (){
                                        context.navigateToOtherScreen(MovieDetailScreen(movieID: widget.knowFor?[index].id,));
                                      },
                                      child: Container(
                                          width: kPS180px,
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: kPS15px,
                                              vertical: kPS15px),
                                          child: StackWidget(
                                              width: kPS50px,
                                              imageWidth: kPS180px,
                                              imageHeight: kPS260px,
                                              imageUrl:
                                                  '$kPrefixImage${widget.knowFor?[index].backdropPath}',
                                              title:
                                                  widget.knowFor?[index].title ??
                                                      "",
                                              voteAverage:
                                                  "${widget.knowFor?[index].voteAverage}",
                                              voteCount:
                                                  "${widget.knowFor?[index].voteCount}")),
                                    );
                                  })
                            ],
                          ),
                        ),
                      ),
                    ));
        },
      ),
    );
  }
}
