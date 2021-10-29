import 'package:app/models/Action.dart';
import 'package:app/models/Organisation.dart';
import 'package:app/models/Cause.dart';

import 'package:app/locator.dart';
import 'package:app/services/dynamicLinks.dart';
import 'package:app/models/Explorable.dart';
import 'package:app/models/Action.dart';

final DynamicLinkService _dynamicLinkService = locator<DynamicLinkService>();

class ListCampaign extends Explorable {
  /// API id for header image 
  final int id;
  final String title;
  final String shortName;

  /// Url of header image 
  final String headerImage;
  final DateTime? startDate;
  final DateTime? endDate;

  /// Has the user completed this campaign
  final bool completed;

  /// The causes that this campaign is part of
  final List<ListCause> _causes;
  // Although at the api level a campaign can be in many causes, for now we are
  // only showing a single cause in the UI.
  ListCause? get cause => _causes.length > 0 ? _causes[0] : null;
 
  /// Returns whether the campaign has ended 
  bool get isPast => endDate == null ? false : DateTime.now().compareTo(endDate!) > 0;

  ListCampaign({
    required int id,
    required String title,
    required String shortName,
    required String headerImage,
    required bool completed,
    required List<ListCause> causes,
    DateTime? startDate,
    DateTime? endDate,
  }) :
    id = id,
    title = title,
    shortName = shortName,
    headerImage = headerImage,
    completed = completed,
    _causes = causes,
    startDate = startDate,
    endDate = endDate;
  
  ListCampaign.fromJson(Map<String, dynamic> json) :
    id = json['id'],
    title = json['title'],
    shortName = json['short_name'],
    headerImage = json['header_image'],
    startDate = json['start_date'],
    endDate = json['end_date'],
    completed = json['completed'],
    _causes = json['causes'].map((causeJson) => ListCause.fromJson(causeJson)).toList().cast<ListCause>();
}

class Campaign extends ListCampaign {
  final String description;
  final String? videoLink;
  final String? infographicUrl;

  final List<Organisation>? generalPartners;
  final List<Organisation>? campaignPartners;

  final List<ListCauseAction>? actions;
  final List<String>? keyAims;

  final int? numberOfCampaigners;
  final int? numberOfActionsCompleted;

  Campaign({
    // Super attributes
    required int id,
    required String title,
    required String headerImage,
    required String shortName,
    required bool completed,
    required List<ListCause> causes,
    DateTime? startDate,
    DateTime? endDate,

    required String description,
    required List<CampaignAction> actions,

    required String videoLink,
    required String infographicUrl,
    required int numberOfCampaigners,
    required int numberOfActionsCompleted,

    List<Organisation>? generalPartners,
    List<Organisation>? campaignPartners,
    List<String>? keyAims,

  }) : 
    // Default lists to empty
    description = description,
    generalPartners = generalPartners ?? [],
    campaignPartners = campaignPartners ?? [],
    keyAims = keyAims ?? [],
    videoLink = videoLink,
    infographicUrl = infographicUrl,
    numberOfCampaigners = numberOfCampaigners,
    numberOfActionsCompleted = numberOfActionsCompleted,
    actions = actions,
    super(id: id, title: title, headerImage: headerImage, shortName: shortName, startDate: startDate, endDate: endDate, completed: completed, causes: causes);

  Campaign.fromJson(Map<String, dynamic> json) : 
      description = json['description_app'].replaceAll('\\n', '\n\n'),
      numberOfCampaigners = json['number_of_campaigners'],
      numberOfActionsCompleted = json['number_of_completed_actions'],
      infographicUrl = json['infographic_url'],
      actions = json['actions'].map((e) => ListCauseAction.fromJson(e)).toList().cast<ListCauseAction>(),
      campaignPartners = json['campaign_partners'].map((e) => Organisation.fromJson(e)).toList().cast<Organisation>(),
      generalPartners = json['general_partners'].map((e) => Organisation.fromJson(e)).toList().cast<Organisation>(),
      videoLink = json['video_link'],
      keyAims = json['key_aims'].map((a) => a['title']).toList().cast<String>(),
      super.fromJson(json);

  Future<String> getShareText() async {
    Uri uri = await _dynamicLinkService.createDynamicLink(
      linkPath: "campaigns/$id",
      title: title,
      description: description,
      imageUrl: headerImage,
    );
    return "Check out the $title campaign on now-u! ${uri.toString()}";
  }
}
