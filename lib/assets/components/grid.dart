import 'package:flutter/material.dart';

typedef Widget GridItemBuilder(BuildContext context, int rowIndex, int colIndex, int index);

class ExpandedGrid extends StatelessWidget {
  /// A list (column) of list (rows) of widgets
  final List<List<Widget>> items;

  ExpandedGrid({
    this.items,
  });

  static Widget builder({
    @required int numberOfRows,
    @required int itemCount,
    @required GridItemBuilder itemBuilder,
  }) {
    List<List<Widget>> widgets = [];
    int numberOfCols = (itemCount / numberOfRows).ceil();
    for (int c = 0; c < numberOfCols; c++) {
      List<Widget> rowWidgets = [];
      for (int r = 0; r < numberOfRows; r++) {
        rowWidgets.add(Builder(
          builder: (context) => itemBuilder(context, r, c, c*numberOfRows + r))
        );
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
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: row
        )
      ).toList()
    );
  }
}
