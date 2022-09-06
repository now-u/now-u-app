import 'package:app/assets/icons/customIcons.dart';
import 'package:flutter/widgets.dart';
import 'package:json_annotation/json_annotation.dart';

import 'utils.dart';

part 'Cause.g.dart';

@JsonSerializable()
class ListCause {
  final int id;
  // TODO rename
  @JsonKey(name: "name")
  final String title;

  @JsonKey(fromJson: authBooleanSerializer, name: "joined")
  final bool selected;

  @JsonKey(fromJson: getIconFromString)
  final IconData icon;

  final String description;
  @JsonKey(name: "image")
  final String headerImage;

  const ListCause({
    required this.id,
    required this.title,
    required this.icon,
    required this.description,
    required this.headerImage,
    required this.selected,
  });

  factory ListCause.fromJson(Map<String, dynamic> data) =>
      _$ListCauseFromJson(data);
}
