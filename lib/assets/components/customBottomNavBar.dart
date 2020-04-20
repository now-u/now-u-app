import 'package:flutter/material.dart';

//import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:app/assets/routes/customRoute.dart';
//import 'package:secta/event/event.dart';
import 'package:app/pages/home/Home.dart';

class CustomBottomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 36.0, right: 36.0, bottom: 16.0, top: 20.0) ,
      child: Material(
        color: Color.fromRGBO(0, 0, 0, 0.0),
        elevation: 10.0,
        shadowColor:  Color.fromRGBO(69, 91, 99, 0.1),
        child: Container(
          margin: EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(50.0))
          ),
          child: Padding(
              padding: EdgeInsets.fromLTRB(40, 0, 40, 0), // How far icons are from edge of NavBar
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  //customIcon(Icon(Icons.home), Home(), context),
                  //customIcon(Icon(Icons.home), Home(), context),
                  //customIcon(Icon(Icons.perm_identity), Home(), context),
                ],
                ),
              )
        ),
      ),
    );
  }
}

Widget customIcon(Icon i, Widget route, BuildContext context){
  return Padding(
    padding: const EdgeInsets.fromLTRB(32.0, 8.0, 32.0, 8.0), // How far apart icons are and padding from top/bottom
    child: IconButton(
        icon: i,
        iconSize: 30.0,
        onPressed: (){
          Navigator.push(
            context,
            CustomRoute(builder: (context) => route),
          );
        },
    ),
  );
}
