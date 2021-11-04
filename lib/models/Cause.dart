import 'package:app/assets/icons/customIcons.dart';
import 'package:app/models/Action.dart';
import 'package:flutter/widgets.dart';

class ListCause {
  final int id;
  final String title;
  final IconData icon;
  final String description;
  final bool selected;

  ListCause({
    required this.id,
    required this.title,
    required this.icon,
    required this.description,
    required this.selected,
  });

  ListCause.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        icon = getIconFromString(json['icon']),
        description = json['description'],
        selected = json['selected'];
}

class Cause extends ListCause {
  final String headerImage;
  final List<ListCauseAction> actions;

  Cause({
    required this.headerImage,
    required this.actions,
    required int id,
    required String title,
    required IconData icon,
    required String description,
    required bool selected,
  }) : super(
            id: id,
            title: title,
            icon: icon,
            description: description,
            selected: selected);

  Cause.fromJson(Map<String, dynamic> json)
      : headerImage = json['header_image'],
        actions = json['actions']
            .map((actionData) => ListCauseAction.fromJson(actionData))
            .toList()
            .cast<ListCauseAction>(),
        super.fromJson(json);
}
