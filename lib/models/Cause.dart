import 'package:causeApiClient/api.dart';
import 'package:get/utils.dart';
import 'package:nowu/assets/icons/customIcons.dart';
import 'package:flutter/widgets.dart';
import 'package:json_annotation/json_annotation.dart';

import 'utils.dart';

part 'Cause.g.dart';

extension on ListCause {
	IconData get getIcon {
		return getIconFromString(this.icon);
	}
}

// @JsonSerializable()
// class ListCause {
//   final int id;
//   // TODO rename
//   @JsonKey(name: "name")
//   final String title;
// 
//   @JsonKey(fromJson: authBooleanSerializer, name: "joined")
//   final bool isSelected;
// 
//   @JsonKey(fromJson: getIconFromString)
//   final IconData icon;
// 
//   final String description;
//   @JsonKey(name: "image")
//   final String headerImage;
// 
//   const ListCause({
//     required this.id,
//     required this.title,
//     required this.icon,
//     required this.description,
//     required this.headerImage,
//     required this.isSelected,
//   });
// 
//   factory ListCause.fromJson(Map<String, dynamic> data) =>
//       _$ListCauseFromJson(data);
// }
