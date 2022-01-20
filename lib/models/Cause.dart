import 'package:app/assets/icons/customIcons.dart';
import 'package:app/models/Action.dart';
import 'package:flutter/widgets.dart';

class ListCause {
  final int id;
  final String title;
  final IconData icon;
  final String description;
  final bool selected;
  final String headerImage;

  ListCause({
    required this.id,
    required this.title,
    required this.icon,
    required this.description,
    required this.selected,
    required this.headerImage,
  });

  ListCause.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        icon = getIconFromString(json['icon']),
        description = json['description'],
        selected = json['selected'],
        headerImage = json['header_image'];
}

class Cause extends ListCause {
  final List<ListCauseAction> actions;

  Cause({
    required this.actions,
    required int id,
    required String title,
    required IconData icon,
    required String description,
    required bool selected,
    required String headerImage,
  }) : super(
          id: id,
          title: title,
          icon: icon,
          description: description,
          selected: selected,
          headerImage: headerImage,
        );

  Cause.fromJson(Map<String, dynamic> json)
      : actions = json['actions']
            .map((actionData) => ListCauseAction.fromJson(actionData))
            .toList()
            .cast<ListCauseAction>(),
        super.fromJson(json);
}
