import 'package:flutter/material.dart';

import '../constant/dimens.dart';

class CustomTable extends StatelessWidget {
  final List<List<String>> data;

  const CustomTable({required this.data});

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(),
      children: data.map((rowData) {
        return TableRow(
          children: rowData.map((cellData) {
            return Container(
              margin: const EdgeInsets.only(top:kPS10px,bottom: kPS10px,),
              child: Text(
                cellData,
                style: const TextStyle(color: Colors.white),
              ),
            );
          }).toList(),
        );
      }).toList(),
    );
  }
}
