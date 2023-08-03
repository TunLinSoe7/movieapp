import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constant/dimens.dart';
import '../../data/vos/genres_vo/genres_vo.dart';
import '../home_page_bloc/home_page_bloc.dart';
class GenreItemView extends StatelessWidget {
  const GenreItemView({super.key, required this.genreList, required this.index, required this.indexData});
  final GenresVO genreList;
  final int index,indexData;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<HomePageBloc>().increase(index);
        context.read<HomePageBloc>().getData(genreList.id ?? 0);
      },
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(kPS8px),
        margin: const EdgeInsets.symmetric(
            horizontal: kPS10px),
        decoration: BoxDecoration(
            color: indexData == index
                ? Colors.redAccent
                : null,
            borderRadius: BorderRadius.circular(kPS5px)),
        child: genreList==null
            ? const CircularProgressIndicator(
          color: Colors.red,
        )
            : Text(
          "${genreList?.name}",
          style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: kPS16px),
        ),
      ),
    );
  }
}