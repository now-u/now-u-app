import 'package:flutter/material.dart';
import 'package:app/assets/components/pageTitle.dart';
import 'package:app/models/User.dart';



class DetailsPage extends StatefulWidget {
  User _user;
  GestureTapCallback _goBack;
  
  DetailsPage(User user, goBack) {
    _user = user; 
    _goBack = goBack;
  }
  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    Map userData = widget._user.getAttributes();
    return Column(
       children: <Widget>[
        PageTitle("My Details", hasBackButton: true, onClickBackButton: widget._goBack,),
        Expanded(
          child: 
            ListView.separated(
              separatorBuilder: (context, index) => Divider(),
              itemCount: userData.length,
              itemBuilder: (context, index) => Text(userData.entries.toList()[index].value.toString()),
            ),
            )
       ], 
        );
  }
}
