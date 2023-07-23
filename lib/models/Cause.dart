import 'package:causeApiClient/causeApiClient.dart';
import 'package:nowu/assets/icons/customIcons.dart';
import 'package:flutter/widgets.dart';
import 'package:causeApiClient/src/model/icon_enum.dart';

export 'package:causeApiClient/causeApiClient.dart' show Cause, IconEnum;

extension IconEnumExtension on IconEnum {
	IconData toIconData() {
		// TODO Update this function to take in icon enum and use icon enum everywhere
		return getIconFromString(this.toString());
	}
}
