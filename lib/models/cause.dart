import 'package:logging/logging.dart';
import 'package:causeApiClient/causeApiClient.dart' as Api;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nowu/assets/icons/customIcons.dart';
import 'package:flutter/widgets.dart';
import 'package:causeApiClient/src/model/icon_enum.dart';
import 'package:nowu/models/user.dart';
import 'package:nowu/models/exploreable.dart';

export 'package:causeApiClient/causeApiClient.dart' show Cause, IconEnum;

final _logger = Logger('IconEnumExtension');

extension IconEnumExtension on IconEnum {}

class Cause implements Explorable {
  final int id;
  final String title;
  final String description;
  final IconData icon;
  final bool isSelected;
  final Api.Image headerImage;

  Cause({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.isSelected,
    required this.headerImage,
  });

  Cause.fromApiModel(Api.Cause apiModel, CausesUser? userInfo)
      : id = apiModel.id,
        title = apiModel.title,
        description = apiModel.description,
        headerImage = apiModel.headerImage,
        icon = _iconFromApiModelIcon(apiModel.icon),
        isSelected = userInfo?.selectedCausesIds.contains(apiModel.id) ?? false;
}

IconData _iconFromApiModelIcon(IconEnum icon) {
  switch (icon) {
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

  _logger.severe('Unknown IconEnum: $icon');
  return FontAwesomeIcons.solidCircle;
}
