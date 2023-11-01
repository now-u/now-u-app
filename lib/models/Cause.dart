import 'package:logging/logging.dart';
import 'package:causeApiClient/causeApiClient.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nowu/assets/icons/customIcons.dart';
import 'package:flutter/widgets.dart';
import 'package:causeApiClient/src/model/icon_enum.dart';

export 'package:causeApiClient/causeApiClient.dart' show Cause, IconEnum;

final _logger = Logger('IconEnumExtension');

extension IconEnumExtension on IconEnum {
  IconData toIconData() {
    switch (this) {
      case IconEnum.healthWellbeing:
        return CustomIcons.cause_icon_health_wellbeing;
      case IconEnum.equalityHumanRights:
        return CustomIcons.cause_icon_equality_human_rights;
      case IconEnum.environment:
        return CustomIcons.cause_icon_environment;
      case IconEnum.education:
        return CustomIcons.cause_icon_education;
      case IconEnum.safeHomeCommunity:
        return CustomIcons.cause_icon_safe_home_community;
      case IconEnum.economicOpportunity:
        return CustomIcons.cause_icon_economic_opportunity;
    }

    _logger.severe('Unknown IconEnum: $this');
    return FontAwesomeIcons.solidCircle;
  }
}
