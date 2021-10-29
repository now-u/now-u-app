import 'package:flutter/widgets.dart';
import 'package:app/assets/icons/customIcons.dart';
import 'package:app/models/Action.dart';

class ListCause {
  int _id;
  String _title;
  IconData _icon;
  String _description;
  bool _selected;

  int get id => _id;
  String get title => _title;
  IconData get icon => _icon;
  String get description => _description;
  bool get selected => _selected;

  ListCause({
    required int id,
    required String title,
    required IconData icon,
    required String description,
    required bool selected
  }): 
    _id = id,
    _title = title,
    _icon = icon,
    _description = description,
    _selected = selected;
  
  ListCause.fromJson(Map<String, dynamic> json) :
    _id = json['id'],
    _title = json['title'],
    _icon = getIconFromString(json['icon']),
    _description = json['description'],
    _selected = json['selected'];
}

class Cause extends ListCause {
  String _headerImage;
  List<ListCauseAction> _actions;

  String get headerImage => _headerImage;
  List<ListCauseAction> get actions => _actions;

  Cause({
    required String headerImage, 
    required List<ListCauseAction> actions, 
    required int id,
    required String title,
    required IconData icon,
    required String description,
    required bool selected
  }) : 
    _headerImage = headerImage,
    _actions = actions,
    super(id: id, title: title, icon: icon, description: description, selected: selected);

  Cause.fromJson(Map<String, dynamic> json): 
    _headerImage = json['headerImage'],
    _actions = json['actions'].map((actionData) => ListCauseAction.fromJson(actionData)).toList().cast<ListCauseAction>(),
    super.fromJson(json);
}
