import 'package:flutter/material.dart';
import 'package:movie_app/bloc/search_page_bloc/search_page_bloc.dart';
import 'package:movie_app/constant/api_constant.dart';
import 'package:movie_app/constant/dimens.dart';
import 'package:movie_app/data/vos/movie_vo/result_vo.dart';
import 'package:provider/provider.dart';

import 'movie_details.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Back",
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0,
      ),
      body: Selector<SearchPageBloc,TextEditingController>(
        selector: (_,bloc)=>bloc.getController,
        builder: (_,controller,__){
          return Selector<SearchPageBloc, List<MovieVO>?>(
            selector: (_, bloc) => bloc.searchData,
            builder: (_, searchData, __) {
              return Padding(
                padding: const EdgeInsets.all(kPS10px),
                child: Column(
                  children: [
                    SizedBox(
                      height: kPS50px,
                      child: TextField(
                        controller: controller ,
                        style: const TextStyle(color: Colors.white),
                        decoration:   InputDecoration(
                            fillColor: Colors.white.withOpacity(0.3),
                            filled: true,
                            hintText: "Search",
                            hintStyle:  const TextStyle(color: Colors.white),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(kPS10px)
                            )
                        ),
                        onChanged: (text) {
                          Provider.of<SearchPageBloc>(context,listen: false).searchMovies(text);
                        },
                      ),
                    ),
                    const SizedBox(height: kPS20px,),
                    Expanded(
                      child: Selector<SearchPageBloc,bool>(
                        selector: (_,bloc)=>bloc.getVisible,
                        builder: (_,visible,__){
                          return Visibility(
                            visible: controller.text.isEmpty?visible=false:visible=true,
                            child: ListView.builder(
                              itemCount: searchData?.length ?? 0,
                              itemBuilder: (_, index) {
                                return Container(
                                  padding: const EdgeInsets.all(kPS10px),
                                  color: Colors.black12,
                                  child: GestureDetector(
                                    onTap: (){
                                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=> MovieDetailScreen(movieID: searchData?[index].id,)));
                                    },
                                    child: ListTile(
                                      leading: Image.network(
                                          "$kPrefixImage${searchData?[index].posterPath}",width:kPS100px,height: kPS100px,
                                          errorBuilder: (_,error,__)=>Image.network(kNullImage)) ,
                                      title: Text(
                                        "${searchData?[index].title}",
                                        style: const TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
