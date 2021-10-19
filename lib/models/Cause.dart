import 'package:flutter/cupertino.dart';

class ListCause {
  int id;
  String title;
  String icon;
  String description;
  bool selected;
}

class Cause extends ListCause {
  String headerImage;
  List<int> actions;

  Cause(
      {this.id,
      this.title,
      this.icon,
      this.description,
      this.selected,
      this.headerImage,
      this.actions});

  Cause.fromJson(Map json) {
    this.id = json['id'];
    this.title = json['title'];
    this.icon = json['icon'];
    this.description = json['description'];
    this.headerImage = json['headerImage'];
    this.actions = json['actions'];
  }
}

class CauseAction {
  final int id;
  bool actionFetched = false;

  bool get isActionFetched {
    return this.actionFetched;
  }

  CauseAction({@required this.id});
}
