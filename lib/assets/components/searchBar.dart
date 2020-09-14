import 'package:app/assets/StyleFrom.dart';
import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  final double height = 50;
  final double borderRadius = 10;

  final Function onChanged;
  final TextEditingController controller;
  final bool autofocus;

  SearchBar(
    this.onChanged,
    this.controller, {
    this.autofocus,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
            width: double.infinity,
            height: height,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
                color: Color.fromRGBO(238, 238, 238, 1)),
            child: TextField(
              autofocus: autofocus ?? false,
              controller: controller,
              onChanged: onChanged,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 15),
                hintText: "Search for something",
                hintStyle: textStyleFrom(
                    Theme.of(context).primaryTextTheme.headline5,
                    fontWeight: FontWeight.w600,
                    color: Color.fromRGBO(136, 136, 136, 1)),
                border: InputBorder.none,
              ),
            )),
        Align(
            alignment: Alignment.centerRight,
            child: Container(
              height: height,
              width: height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
                color: Theme.of(context).primaryColor,
              ),
              child: IconButton(
                icon: Icon(Icons.search),
                onPressed: () {},
              ),
            ))
      ],
    );
  }
}
