import 'package:flutter/cupertino.dart';

class Cause{
  int id;
  String name;
  String icon;
  String description;
  String headerImage;
  List<int> actions;

  Cause({this.id, this.name, this.icon, this.description, this.headerImage, this.actions});

  Cause.fromJson(Map json){
    this.id = json['id'];
    this.name = json['name'];
    this.icon = json['icon'];
    this.description = json['description'];
    this.headerImage = json['headerImage'];
    this.actions = json['actions'];
  }
}

class CauseAction{
  final int id;
  bool actionFetched = false;

  bool get isActionFetched{
    return this.actionFetched;
  }

  CauseAction({@required this.id});

}