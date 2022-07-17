import 'package:app/assets/icons/customIcons.dart';
import 'package:app/models/Action.dart';
import 'package:flutter/widgets.dart';
import 'package:json_annotation/json_annotation.dart';

// @JsonSerializable()
class ListCause {
  final int id;
  final String title;

  // @JsonKey(fromJson: getIconFromString)
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
        title = json['name'],
        icon = getIconFromString(json['icon']),
        description = json['description'],
        selected = json['joined'] == true,
        headerImage = json['image'];
}

// @JsonSerializable()
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
