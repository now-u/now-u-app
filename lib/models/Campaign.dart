import 'package:app/locator.dart';
import 'package:app/models/Action.dart';
import 'package:app/models/Cause.dart';
import 'package:app/models/Explorable.dart';
import 'package:app/models/Learning.dart';
import 'package:app/models/Organisation.dart';
import 'package:app/services/dynamicLinks.dart';
import 'package:json_annotation/json_annotation.dart';

part 'Campaign.g.dart';

final DynamicLinkService _dynamicLinkService = locator<DynamicLinkService>();

@JsonSerializable()
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

  /// The cause that this campaign is part of
  // Although at the api level a campaign can be in many causes, for now we are
  // only showing a single cause in the UI.
  @JsonKey(fromJson: causeFromJson, name: "causes")
  final ListCause cause;

  /// Returns whether the campaign has ended
  bool get isPast =>
      endDate == null ? false : DateTime.now().compareTo(endDate!) > 0;

  ListCampaign({
    required this.id,
    required this.title,
    required this.shortName,
    required this.headerImage,
    required this.completed,
    required this.cause,
    this.startDate,
    this.endDate,
  });

  factory ListCampaign.fromJson(Map<String,dynamic> data) => _$ListCampaignFromJson(data);
  // ListCampaign.fromJson(Map<String, dynamic> json)
  //     : id = json['id'],
  //       title = json['title'],
  //       shortName = json['short_name'],
  //       headerImage = json['header_image'],
  //       startDate = DateTime.parse(json['start_date']),
  //       endDate = DateTime.parse(json['end_date']),
  //       completed = json['completed'],
  //       cause = ListCause.fromJson(json['causes'][0]);
}

String descriptionFromJson(String value) {
	return value.replaceAll('\\n', '\n\n');
}

@JsonSerializable()
class Campaign extends ListCampaign {
  @JsonKey(fromJson: descriptionFromJson, name: "description_app")
  final String description;
  final String videoLink;
  final String infographicUrl;

  final List<Organisation> generalPartners;
  final List<Organisation> campaignPartners;

  final List<String> keyAims;

  @JsonKey(name: "campaign_actions")
  final List<ListCauseAction> actions;
  final List<LearningResource> learningResources;

  // TODO populate from API
  final int numberOfCampaigners = 0;
  final int numberOfActionsCompleted = 0;

  Campaign({
    // Super attributes
    required int id,
    required String title,
    required String headerImage,
    required String shortName,
    required bool completed,
    required ListCause cause,
    DateTime? startDate,
    DateTime? endDate,
    required this.description,
    required this.actions,
    required this.learningResources,
    required this.videoLink,
    required this.infographicUrl,
    this.generalPartners = const [],
    this.campaignPartners = const [],
    this.keyAims = const [],
  }) : super(
          id: id,
          title: title,
          headerImage: headerImage,
          shortName: shortName,
          startDate: startDate,
          endDate: endDate,
          completed: completed,
          cause: cause,
        );

  factory Campaign.fromJson(Map<String,dynamic> data) => _$CampaignFromJson(data);
  // Campaign.fromJson(Map<String, dynamic> json)
  //     : description = json['description_app'].replaceAll('\\n', '\n\n'),
  //       // numberOfCampaigners = json['number_of_campaigners'],
  //       // numberOfActionsCompleted = json['number_of_completed_actions'],
  //       infographicUrl = json['infographic_url'],
  //   // TODO remove 
  //   actions = [],
  //       // actions = json['campaign_actions']
  //       //     .map((e) => ListCauseAction.fromJson(e,
  //       //         cause: ListCause.fromJson(json['causes'][0])))
  //       //     .toList()
  //       //     .cast<ListCauseAction>(),
  //       learningResources = json['learning_resources']
  //           .map((e) => LearningResource.fromJson(e,
  //               cause: ListCause.fromJson(json['causes'][0])))
  //           .toList()
  //           .cast<LearningResource>(),
  //       videoLink = json['video_link'],
  //       // generalPartners = json['general_partners']
  //       //     .map((e) => Organisation.fromJson(e))
  //       //     .toList()
  //       //     .cast<Organisation>(),
  //       // keyAims =
  //       //     json['key_aims'].map((a) => a['title']).toList().cast<String>(),
  //       // campaignPartners = json['campaign_partners']
  //       //     .map((e) => Organisation.fromJson(e))
  //       //     .toList()
  //       //     .cast<Organisation>(),
  //       keyAims = [],
  //       campaignPartners = [],
  //       generalPartners = [],
  //       super.fromJson(json);

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
