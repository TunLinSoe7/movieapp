import 'package:flutter/material.dart';
class ListViewImageWidget<T> extends StatelessWidget {
  const ListViewImageWidget({Key? key, required this.listViewHeight, required this.itemCount, required this.itemBuilder}) : super(key: key);
final double listViewHeight;
final int? itemCount;
final IndexedWidgetBuilder itemBuilder;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: listViewHeight,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: itemCount,
            itemBuilder: itemBuilder, ));
  }
}

