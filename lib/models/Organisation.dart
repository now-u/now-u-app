import 'package:causeApiClient/causeApiClient.dart';
export 'package:causeApiClient/causeApiClient.dart' show Organisation;

class OrganisationTypeMeta {
  final String name;

  OrganisationTypeMeta({
    required this.name,
  });
}

OrganisationTypeMeta getOrganisationTypeMeta(OrganisationTypeEnum type) {
  switch (type) {
    case OrganisationTypeEnum.CHARITY:
      return OrganisationTypeMeta(name: 'Charity');
    case OrganisationTypeEnum.SOCIAL_ENTERPRISE:
      return OrganisationTypeMeta(name: 'Social Enterprise');
  }
  // TODO Metric + log
  return OrganisationTypeMeta(name: 'Unknown');
}

extension OrganisatiExtension on Organisation {
  // TODO Name this more sensibly
  String get descriptionClean => description.replaceAll('\\n', '\n\n');

  OrganisationTypeMeta get organisationTypeMeta =>
      getOrganisationTypeMeta(organisationType);
}
