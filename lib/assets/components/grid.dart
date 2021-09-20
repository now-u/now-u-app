import 'package:flutter/material.dart';

class ExpandedGrid extends StatelessWidget {
  /// A list (column) of list (rows) of widgets
  final List<List<Widget>> items;

  ExpandedGrid({
    this.items,
  });

  static Widget builder({
    @required int numberOfRows,
    @required int itemCount,
    @required Function itemBuilder,
  }) {
    List<List<Widget>> widgets = [];
    int numberOfCols = (itemCount / numberOfRows).ceil();
    for (int c = 0; c < numberOfCols; c++) {
      List<Widget> rowWidgets = [];
      for (int r = 0; r < numberOfRows; r++) {
        rowWidgets.add(itemBuilder(r, c, c*numberOfRows + r));
      }
      widgets.add(rowWidgets);
    }
    return ExpandedGrid(
      items: widgets 
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: items.map((row) => 
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: row
        )
      ).toList()
    );
  }
}