import 'package:flutter/material.dart';

class ListViewImage<T> extends StatelessWidget {
  const ListViewImage({
    Key? key,
    required this.future,
    this.onTap,
    required this.itemBuilder, required this.lisViewHeight,
  }) : super(key: key);
  final Future<List<T>?> future;
  final void Function()? onTap;
  final double lisViewHeight;
  final Widget Function(BuildContext context, T items) itemBuilder;

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
          final List<T>? movieData = snapshot.data;
          if (movieData == null || movieData.isEmpty) {
            return const Center(
              child: Text("No data available"),
            );
          }
          return SizedBox(
            height: lisViewHeight,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: movieData.length,
              itemBuilder: (context, index) => itemBuilder(context, movieData[index]),
            ),
          );
        }
      },
    );
  }
}
