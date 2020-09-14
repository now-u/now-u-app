import 'package:app/models/Campaign.dart';

class Organisation {
  int id;
  String name;
  String description;
  String logoLink;
  List<int> linkedCampaigns;
  String organisationType;
  String email;
  String website;
  String geographicReach;

  List<Campaign> campaigns;

  String instagram;
  String facebook;
  String twitter;

  String extraText1;
  String extraLink1;
  String extraText2;
  String extraLink2;
  String extraText3;
  String extraLink3;

  Organisation.fromJson(Map json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    logoLink = json['logo_link'];
    organisationType = json['organisation_type'];
    //linkedCampaigns = json['linked_campaigns'].cast<int>();
    email = json['email'];
    website = json['website'];
    geographicReach = json['geographic_reach'];

    instagram = json['IG_link'];
    facebook = json['FB_link'];
    twitter = json['twitter_link'];

    campaigns = json['campaigns'] == null
        ? <Campaign>[]
        : json['campaigns']
            .map((e) => Campaign.fromJson(e))
            .toList()
            .cast<Campaign>();

    extraText1 = json['extra_text_1'];
    extraLink1 = json['extra_link_1'];

    extraText2 = json['extra_text_2'];
    extraLink2 = json['extra_link_2'];

    extraText3 = json['extra_text_3'];
    extraLink3 = json['extra_link_3'];
  }

  Map toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'logo_link': logoLink,
        'linked_campaigns': linkedCampaigns,
        'email': email,
        'website': website,
      };

  String getName() {
    return name;
  }

  String getDescription() {
    var descriptionWithoutNs = description.replaceAll('\\n', '\n\n');
    return descriptionWithoutNs;
  }

  String getLogoLink() {
    return logoLink;
  }

  List<int> getLinkedCampaigns() {
    return linkedCampaigns;
  }

  String getEmail() {
    return email;
  }

  String getWebsite() {
    return website;
  }

  String getGeographicReach() {
    return geographicReach;
  }

  String getOrganistaionType() {
    if (organisationType == null) {
      return null;
    }
    String s = organisationType.replaceAll("_", " ");
    return "${s[0].toUpperCase()}${s.substring(1)}";
  }

  String getFacebook() {
    return facebook;
  }

  String getInstagram() {
    return instagram;
  }

  String getTwitter() {
    return twitter;
  }

  String getExtraText1() {
    return extraText1;
  }

  String getExtraLink1() {
    return extraLink1;
  }

  String getExtraText2() {
    return extraText2;
  }

  String getExtraLink2() {
    return extraLink2;
  }

  String getExtraText3() {
    return extraText3;
  }

  String getExtraLink3() {
    return extraLink3;
  }

  List<Campaign> getCampaigns() {
    return campaigns;
  }
}
