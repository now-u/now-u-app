import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class CauseTile extends StatelessWidget {
  
  final String causeName;
  final IconData iconData;
  
  CauseTile({@required this.causeName, @required this.iconData});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.16),
                  offset: Offset(0, 8),
                  blurRadius: 6)
            ]
    ),
      width: MediaQuery.of(context).size.width * 0.4,
      height: MediaQuery.of(context).size.width * 0.4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Icon(iconData, size: 60.0),
          Center(child: Container(width:  MediaQuery.of(context).size.width * 0.7, child: Text('${causeName}', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold))))
        ],
      )
    );
  }
}
