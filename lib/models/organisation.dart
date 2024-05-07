import 'package:causeApiClient/causeApiClient.dart' as Api;
import 'package:logging/logging.dart';
import 'package:nowu/utils/let.dart';
export 'package:causeApiClient/causeApiClient.dart'
    show OrganisationTypeEnum, Image;

class OrganisationTypeMeta {
  final String name;

  const OrganisationTypeMeta({
    required this.name,
  });
}

const charityType = OrganisationTypeMeta(name: 'Charity');
const socialEnterpriseType = OrganisationTypeMeta(name: 'Social Enterprise');
const unknownType = OrganisationTypeMeta(name: 'Unknown');
final _logger = Logger('Organisation');

OrganisationTypeMeta getOrganisationTypeMeta(Api.OrganisationTypeEnum type) {
  switch (type) {
    case Api.OrganisationTypeEnum.CHARITY:
      return charityType;
    case Api.OrganisationTypeEnum.SOCIAL_ENTERPRISE:
      return socialEnterpriseType;
  }
  _logger.severe('Unknown organisationType: $type');
  return unknownType;
}

class OrganisationExtraLink {
  final String title;
  final Uri link;

  OrganisationExtraLink(Api.OrganisationExtraLink apiModel)
      : this.title = apiModel.title,
        this.link = Uri.parse(apiModel.link);
}

class Organisation {
  final int id;
  final String name;
  final Api.Image logo;
  final String description;
  final String? geographicReach;
  final Uri? instagramLink;
  final Uri? twitterLink;
  final Uri? facebookLink;
  final String? emailAddress;
  final Uri? websiteLink;
  final List<OrganisationExtraLink> extraLinks;
  final Api.OrganisationTypeEnum type;

  OrganisationTypeMeta get organisationTypeMeta =>
      getOrganisationTypeMeta(type);
  Uri? get mailToLink =>
      emailAddress?.let((emailAddress) => Uri.parse('mailto:${emailAddress}'));

  Organisation(Api.Organisation apiModel)
      : id = apiModel.id,
        name = apiModel.name,
        logo = apiModel.logo,
        geographicReach = apiModel.geographicReach,
        description = apiModel.description.replaceAll('\\n', '\n\n'),
        instagramLink = apiModel.instagramLink?.let((link) => Uri.parse(link)),
        twitterLink = apiModel.twitterLink?.let((link) => Uri.parse(link)),
        facebookLink = apiModel.facebookLink?.let((link) => Uri.parse(link)),
        emailAddress = apiModel.emailAddress,
        websiteLink = apiModel.websiteLink?.let((link) => Uri.parse(link)),
        extraLinks = apiModel.extraLinks
            .map((link) => OrganisationExtraLink(link))
            .toList(),
        type = apiModel.organisationType;
}
