import 'package:flutter/cupertino.dart';

class ListCause {
  int? id;
  String? title;
  String? icon;
  String? description;
  bool? selected;

  ListCause({this.id, this.title, this.icon, this.description, this.selected});
  
  ListCause.fromJson(Map json) {
    this.id = json['id'];
    this.title = json['title'];
    this.icon = json['icon'];
    this.description = json['description'];
    this.selected = json['selected'];
  }
}

class Cause extends ListCause {
  String? headerImage;
  List<int>? actions;

  Cause({this.headerImage, this.actions, int? id, String? title, String? icon, String? description, bool? selected})
      : super(id: id, title: title, icon: icon, description: description, selected: selected);

  Cause.fromJson(Map json): super.fromJson(json) {
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

  CauseAction({required this.id});
}
